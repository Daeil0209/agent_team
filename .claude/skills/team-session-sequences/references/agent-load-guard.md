---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Agent Load Guard
To prevent agent overload, each dispatch must stay within these bounds:

- **Focused dispatch per agent**: each agent must receive a focused, single-purpose task. Parallel dispatch of multiple agents is fine when tasks are independent. The overload risk comes from giving one agent too many diverse topics at once, not from running multiple agents simultaneously.
- **Questions per dispatch**: maximum 2 focused questions.
- **Files per dispatch**: maximum 5 explicitly named file paths.
- **Judgment types per dispatch**: maximum 1; do not combine investigation, risk assessment, and recommendation in one dispatch.
- **Context carry-forward**: when dispatching step N, include the concrete output of step N-1, not a pointer to "previous results".

If a dispatch exceeds any bound, decompose it before sending. Exception: researcher assignments requiring `deep-evidence` coverage may receive broader file scope when cross-file pattern discovery is required, but the question count limit still applies.
