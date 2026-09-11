import type { Api, Model } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const LUNA_SKILL_COMMAND = /^\/skill:(?:commit|rewrite)(?:\s|$)/;

export default function skillModelExtension(pi: ExtensionAPI) {
    let previous: { model: Model<Api>; thinkingLevel: ReturnType<typeof pi.getThinkingLevel> } | undefined;

    pi.on("input", async (event, ctx) => {
        if (!LUNA_SKILL_COMMAND.test(event.text)) {
            return;
        }

        const model = ctx.modelRegistry.find("openai-codex", "gpt-5.6-luna");
        if (!model) {
            ctx.ui.notify("This skill requires openai-codex/gpt-5.6-luna, but it is unavailable.", "error");
            return { action: "handled" };
        }

        const saved = ctx.model ? { model: ctx.model, thinkingLevel: pi.getThinkingLevel() } : undefined;
        if (!(await pi.setModel(model))) {
            ctx.ui.notify("This skill requires credentials for openai-codex/gpt-5.6-luna.", "error");
            return { action: "handled" };
        }

        previous = saved;
        pi.setThinkingLevel("minimal");
    });

    pi.on("agent_settled", async (_event, ctx) => {
        const saved = previous;
        previous = undefined;
        if (!saved) {
            return;
        }

        if (!(await pi.setModel(saved.model))) {
            ctx.ui.notify("Could not restore the model used before the skill.", "error");
            return;
        }
        pi.setThinkingLevel(saved.thinkingLevel);
    });
}
