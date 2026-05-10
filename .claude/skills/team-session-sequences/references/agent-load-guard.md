---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Agent Load Guard
To prevent agent overload, each dispatch must stay within these bounds:

- **Focused dispatch per agent**: each agent must receive a focused, single-purpose task. Parallel dispatch of multiple agents is fine when tasks are independent. The overload risk comes from giving one agent too many diverse topics at once, not from running multiple agents simultaneously.
- **Question surface**: one coherent question set per dispatch.
- **File surface**: one bounded, explicitly named file group per dispatch.
- **Judgment mode**: one judgment mode per dispatch. Distinct investigation, risk assessment, and recommendation surfaces use separate dispatches.
- **Context carry-forward**: when dispatching step N, include the concrete output of step N-1 rather than a pointer to "previous results".

If a dispatch mixes boundaries, decompose it before sending. Exception: researcher assignments requiring `deep-evidence` coverage may receive broader file scope when cross-file pattern discovery is required, but the question surface must stay coherent.

## Next-Action Drive
- In-bounds dispatch returns to `task-execution` packet send.
- Mixed-boundary dispatch opens packet decomposition.
- Researcher `deep-evidence` exception records the cross-file pattern basis before send.
