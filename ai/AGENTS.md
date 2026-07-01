
# Maria's agent instructions

## General Guidelines

* Never use the em dash "-". Use plain dash "-" instead
* When writing emails, never start with generic sentences like "Hope you are doing well" or "I hope this email finds you well". Finish emails with "Best, \n Maria". 
* Avoid overusing checklists / itemized lists when summarizing points. Instead, write long sentences and paragraphs. Only use itemized lists when it's really necessary.
* When writing commit messages, emails or any documents, NEVER auto-add your agent name as co-author
* Never manually modify CHANGELOG.md files or any files that are marked as auto-generated
* When writing or substantially editing long Markdown files, put each full sentence on its own line.
* Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.
* When making technical decisions, do not give much weight to development cost. Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability. When doing bug fixes, always start with reproducing the the bug bug in an E2E setting as closely aligned with how an end user would use the product. This makes sure you find the real problem so your fix will actually solve it.
* When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection. If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along.
* Apply that same high standard to engineering excellence: lint, test failures, and test flakiness. If you see one, even if it is not caused by what you are working on right now, still get it fixed.

## Maria's Opinions

When you are working on something that would benefit from being informed by Maria's viewpoints, read ~/OPINIONS.md to understand her though process better. 

## Maria's voice

When you are talking/posting/writing on behalf of Maria, read ~/VOICE.md to see how she talks.