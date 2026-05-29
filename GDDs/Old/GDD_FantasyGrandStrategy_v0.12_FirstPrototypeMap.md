# Game Design Document
## *Working Title: AXIOM* — Fantasy Grand Strategy
**Version 0.12 — First Prototype Map Added**

---

> *Every game is a new world. You don't know the rules until you discover them.*

---

## Table of Contents

1. [Vision Statement](#1-vision-statement)
2. [Core Philosophy](#2-core-philosophy)
3. [The Five Pillars](#3-the-five-pillars)
4. [System: World Generation](#4-system-world-generation)
5. [System: Material Science & Discovery](#5-system-material-science--discovery)
6. [System: Logistics & Supply Chains](#6-system-logistics--supply-chains)
7. [System: Factions & Legacy Empires](#7-system-factions--legacy-empires)
8. [System: The Living Map (Real-Time)](#8-system-the-living-map-real-time)
9. [The Core Gameplay Loop](#9-the-core-gameplay-loop)
10. [Victory Conditions](#10-victory-conditions)
11. [Open Design Questions](#11-open-design-questions)
12. [Out of Scope (For Now)](#12-out-of-scope-for-now)
13. [Prototype Scope Definition — Discovery-First v0.1](#13-prototype-scope-definition--discovery-first-v01)

---

## 1. Vision Statement

**AXIOM** is a single-player fantasy grand strategy game in which every new game generates a fundamentally different world — not just a different map, but a world with different physical and magical laws. Resources have unknown properties. Factions have asymmetric strengths and hidden agendas. Armies march in slow real-time across a living map. Ore must be mined, carted, analyzed, and forged before it becomes a weapon.

The player cannot rely on accumulated meta-knowledge of "what works." Every game demands fresh investigation, adaptation, and strategy built from what *this* world actually is.

The closest inspirations are **Crusader Kings III** (emergent faction drama), **Stellaris** (asymmetric legacy powers), **Dwarf Fortress** (systemic depth and emergent discovery), and **Victoria 3** (logistics and supply chains) — but no existing game combines these pillars.

---

## 2. Core Philosophy

**The world is a mystery, not a menu.**
Most strategy games present the player with full information from turn one. In AXIOM, the world reveals itself. You don't know what your ore does until you study it or use it. You don't know what the ancient empire to your north wants until you interact — or fail to.

**Everything is physical and real.**
There are no invisible transactions. Resources move. Armies march. Caravans travel roads. Every action has a visible presence in the world that can be watched, intercepted, disrupted, or protected.

**Asymmetry is a feature, not a bug.**
The world is not balanced. Some factions will be stronger than you. Some starting positions are harder than others. The game is not designed to be fair — it is designed to be *interesting*. Fairness comes from the player's ability to adapt, ally, or avoid.

**Strategy emerges from knowledge.**
The player who wins is not the one who memorized the optimal build order. It is the one who best understood *this* world's specific rules, materials, factions, and opportunities.

---

## 3. The Five Pillars

| Pillar | Summary |
|--------|---------|
| **Procedural World Laws** | Physical + magic + divine layers generate a unique world each game |
| **Material Science & Discovery** | Resources have unknown properties discovered through research and field use |
| **Logistics & Supply Chains** | Every resource physically moves; every step is visible and vulnerable |
| **Legacy Empires** | Asymmetric AI powers with hidden personalities and world-scale agendas |
| **The Living Map** | Slow real-time; armies march, caravans travel, the world breathes |
| **Tactical Battles** | Conflicts resolve on a grid-based tactical map with persistent, customizable squads |

---

## 4. System: World Generation

World generation occurs in three sequential passes. Each pass builds on the last, creating a world that feels consistent but unique.

### 4.1 Pass One — Physical Layer

The physical layer determines the base properties of the world's raw materials. This is done *before* the player sees anything.

Every world has a set of **material archetypes** — the roles that need filling (structural metal, soft metal, dense stone, light stone, hard wood, soft wood, etc.). For each archetype, a material is generated with:

- **Base physical properties**: hardness, weight, conductivity, flexibility, flammability, density
- **Aesthetic traits**: color, texture, smell, sound when struck — things the player can observe without knowing meaning
- **Rarity and distribution**: how common it is, in what biomes, at what depths

The player does not see property values — only the aesthetic traits and the archetype role (e.g., "a reddish, heavy ore found in volcanic foothills").

**Wildlife and food** are also affected. Animals may be unusually dense (hard to kill), unusually fast, or produce materials (hides, bones, venom) with surprising properties. Crops may grow faster in certain soils, have nutritional anomalies, or taste unusual.

### 4.2 Pass Two — Magic Layer

After the physical layer, a magic pass runs over the world. Not all materials are affected — magic is not omnipresent. The density of magic in a given world is itself a generated parameter (some worlds feel almost mundane; some crackle with it).

For each material flagged for magical influence, one or more **magical properties** are layered on:

| Category | Examples |
|----------|----------|
| Elemental resistance/conductivity | Fire-resistant, cold-retaining, lightning-attractive |
| Force/weight anomalies | Levitating, compressing, rebounding |
| Biological effects | Flesh-knitting, poisonous to undead, maddening to animals |
| Temporal quirks | Slow-decaying, rapid-growth-inducing |
| Spiritual resonance | God-blessed, void-touched, ancestor-haunted |

Magical properties are *also* hidden at game start. The world is not labeled.

**Terrain** may also be magically affected — a forest that induces calm, a mountain pass that causes confusion, a river that purifies disease.

### 4.3 Pass Three — Divine Layer

Gods exist in every game, but their number, nature, and power vary. Each deity is generated with:

- **A domain** (war, harvest, rivers, secrets, fire, decay, etc.)
- **A personality** (wrathful, generous, indifferent, jealous, capricious)
- **A preferred form of worship** (sacrifice, building, silence, conquest, song)
- **A starting presence** in the world — which regions feel their influence, and how strongly

Gods are not abstractions. Their personality affects the world passively. A harvest god who is pleased makes their favored region more fertile. A war god who is neglected makes their sacred sites dangerous. The world expresses divine mood through observable phenomena.

**Cult growth** (later feature): As a god's cult grows, their influence scales — eventually reshaping terrain, awakening dormant blessings or curses, or intervening in conflicts directly.

---

## 5. System: Material Science & Discovery

This is the intellectual spine of the game. Understanding what the world is made of is a strategic advantage as powerful as military might.

Discovery is not a single action — it is a **layered process with a natural cost curve**. The easy things are learned quickly and cheaply. The interesting things take investment, time, and sometimes luck.

### 5.1 The Five Tiers of Discovery

#### Tier 1 — Immediate Observation *(on first contact, free)*

The moment a material is encountered, basic physical qualities are communicated through **qualitative natural language**. No facilities required. No time investment.

The player sees descriptions like:
- *"This ore is notably dense. It rings clearly when struck."*
- *"This timber is unexpectedly hard — your axe bites shallowly."*
- *"The stone is light and slightly warm to the touch."*
- *"This grain smells faintly sweet and grows in unusually dry soil."*

These descriptions are intentionally qualitative, not numerical. They give the player enough to reason with — "this metal seems strong, worth pursuing" — without revealing mechanical values. Faction background affects the richness of Tier 1 language (see 5.2).

#### Tier 2 — Practical Testing *(cheap facility, short time)*

A basic workshop or smith can run simple physical tests: stress-testing hardness, measuring weight against known standards, burning small samples, testing flexibility. This takes days of in-game time and confirms or refines Tier 1 observations with more specificity.

Results are still descriptive, but more precise:
- *"Harder than common iron, but notably more brittle under lateral stress."*
- *"Burns slowly and produces an unusual blue flame before self-extinguishing."*
- *"Floats in water. Your smiths have never seen metal behave this way."*

Tier 2 fully maps the **physical property space** of a material. At this point the player knows what the material can do physically and how to use it practically. Magical properties remain invisible.

#### Tier 3 — Formal Analysis *(Wizard School / Academy, significant time and cost)*

A dedicated research facility — staffed by scholars or mages — can probe a material's magical resonance. This requires:
- A physical sample delivered to the facility
- Staffing by at least one qualified researcher
- Time (weeks to months of in-game time depending on staff quality)

Analysis peels back magical properties in layers. A single analysis run might reveal one or two properties; a full picture may take multiple sessions or a more advanced facility. Results are logged in the player's material codex.

Some magical properties are subtle and may be described ambiguously at first:
- *"The material exhibits faint thermal anomalies under magical stress. Further study warranted."*
- *"Scholars note an unusual interaction with divine-aligned enchantments. Nature unclear."*

#### Tier 4 — Field Discovery *(emerges naturally through use)*

Some properties — especially conditional or reactive ones — only reveal themselves in the field. No amount of laboratory study will find them because they only activate under the right circumstances.

Examples:
- Armor made from an unknown ore survives a fire attack that should have been lethal. The property surfaces as an event: *"Your soldiers emerged from the blaze unharmed. The ore seems to resist fire."*
- A weapon made from a magically sharp material produces unusual wound results after a battle. *"Enemy casualties were higher than expected. Physicians note the wounds are unusually precise."*
- A crop grown in volcanic soil begins feeding twice as many people as expected. *"Your granary records suggest this grain yields more than expected on this soil."*

Field discovery is **slower but richer** — it sometimes reveals properties that formal analysis cannot, and it generates narrative events that formal analysis never would.

#### Tier 5 — Alloy Experimentation *(Alchemist's Workshop, combinatorial)*

Alloys are their own discovery layer. Two or more materials combined by a skilled smith produce a new material whose properties must be discovered from scratch — though prior knowledge of component materials provides useful starting hypotheses.

Alloy behavior follows internal rules the player must uncover:

- Properties generally **combine** (armor inherits traits from both source materials)
- Some properties **conflict** and partially cancel or destabilize each other
- Some properties **amplify** in combination — an unexpected synergy
- Rare combinations produce **emergent properties** not present in either source material alone

The combinatorial space grows quickly. A world with eight notable materials has dozens of potential two-way alloys, and the player will never have time to fully explore them all. Choosing which combinations to prioritize is itself a strategic decision.

Rivals are also experimenting. An AI faction may discover a devastating alloy combination before the player does.

---

### 5.2 Faction Knowledge Modifiers

A faction's background and culture shapes what they can observe immediately and how quickly they learn.

| Faction Background | Tier 1 Advantage | Tier 3 Advantage |
|-------------------|-----------------|-----------------|
| Mountain/Forge culture | Richer metal descriptions at Tier 1; Tier 2 metal tests faster | — |
| Forest/Druidic culture | Richer wood, plant, and wildlife descriptions at Tier 1 | May detect nature-aligned magical properties faster |
| Scholarly/Academy culture | — | Formal analysis runs faster; more properties per session |
| Nomadic/Trader culture | Broader Tier 1 observations (more materials recognized on sight) | — |
| Priestly/Divine culture | — | Spiritual resonance properties detected faster |

These are not numerical stat bonuses — they manifest as *richer descriptive language* and *shorter time investments* in specific areas. A mountain people doesn't get a "+10% ore analysis speed" tooltip; they get a smith who says *"I've seen metals like this before — it's hard, but I'd watch for brittleness under cold"* before you've run a single test.

---

### 5.3 Crafting Without Full Knowledge

Players are never required to complete discovery before crafting. The game actively encourages using materials before fully understanding them:

- Equipment inherits properties the player hasn't identified yet
- Those properties reveal over time through field use (Tier 4)
- Results can be positive, negative, or surprising

A commander outfitted in unknown-alloy armor might survive something that should have killed them. A regiment equipped with a strange new blade might be feared by enemies for reasons no one fully understands yet. The world teaches through experience.

---

### 5.4 The Material Codex

All discovery progress is tracked in a **Material Codex** — a persistent in-game document that grows as the player learns. Each material has a page that fills in over time:

- Physical description (Tier 1, always visible)
- Practical properties (Tier 2, fills in after testing)
- Magical properties (Tier 3/4, fills in as discovered)
- Alloy records (Tier 5, documents experiments and outcomes)
- Field notes (narrative entries generated by field discovery events)

The codex is the player's accumulated understanding of *this* world. In a new game, it starts blank.

---

## 6. System: Logistics & Supply Chains

Every resource in AXIOM must physically travel from its point of origin to its point of use. There are no instant transfers.

### 6.1 The Full Production Chain

Below is a complete example of what bringing a material to military use actually requires:

```
[Deposit Found]
      ↓
[Survey] — establishes exact size and surface properties
      ↓
[Mine Construction] — workers, building materials, time
      ↓
[Mining Operation] — ongoing; requires staffing and maintenance
      ↓
[Raw Ore Stockpile]
      ↓
[Cart / Caravan dispatched] — visible on map, followable
      ↓
    ┌──────────────────────────────┐
    │                              │
[Wizard School]              [Processing Site]
[Analyze sample]             [Smelt / Refine ore]
[Reveal properties]               ↓
                           [Refined Material Stockpile]
                                  ↓
                           [Blacksmith / Armory]
                           [Craft equipment]
                                  ↓
                           [Equipment Stockpile]
                                  ↓
                           [Transport to Army]
                                  ↓
                           [Equipped Unit]
```

Each node in this chain:
- Takes time to build
- Requires staffing
- Can be attacked, raided, or disrupted
- Can be upgraded for efficiency
- Can be captured and used by enemies

### 6.2 Caravans and Convoys

Physical goods move by caravan — a visible entity on the map with:

- **A route** (player-assigned, following roads or terrain)
- **A cargo** (visible to the player; discoverable by enemies who intercept)
- **A speed** (based on terrain, road quality, load)
- **A guard level** (unescorted caravans are easy prey; heavily guarded ones are expensive)

Players must actively manage major supply routes. Critical ore convoys traveling through contested or dangerous territory need military escort. An enemy who learns your ore routes can strangle your production without ever besieging your capital.

### 6.3 Processing Facilities

Some materials require specific processing before use. Processing facilities can be:

- Built at the deposit (reduces transport but puts infrastructure in a potentially exposed location)
- Built centrally (safer, but ore must travel further)
- Specialized (a master blacksmith produces better equipment; a larger wizard school analyzes faster)

Facilities can be staffed by general workers or by specialists. Specialists are rare, hireable characters with personal traits and skills.

### 6.4 Disruption and Warfare

Logistics chains are military targets. A sophisticated enemy (including AI) may:

- Raid caravans to deny resources
- Burn processing facilities
- Poach or assassinate specialist workers
- Capture a mine and turn the supply chain against you

Players must balance production efficiency against logistics security.

---

## 7. System: Factions & Legacy Empires

### 7.1 Player Faction

At game start, the player selects or is assigned a faction. Factions are generated with:

- A starting territory and population
- Cultural traits that affect what materials they're drawn to, how they govern, what gods they favor
- A starting discovery state (some factions begin with partial knowledge of nearby materials — a mountain people might already know the basics of local ore)
- No guaranteed advantage over AI factions

### 7.2 AI Factions

Standard AI factions compete, expand, and pursue their own goals. They run logistics chains, analyze materials, make alliances, and go to war. They are not omniscient — they also discover the world as they go.

AI factions have:
- **Personalities** (expansionist, isolationist, scholarly, mercantile, religious)
- **Priorities** (what they value — territory, rare materials, divine favor, trade)
- **Agendas** (mid- and long-term goals the player can sometimes observe and sometimes not)

### 7.3 Legacy Empires

Present at game start. Ancient, powerful, with deep roots in the world. They do not start as enemies or allies — they simply *exist*, with their own slow momentum.

Each Legacy Empire is generated with a **personality archetype** and a **hidden arc**:

| Archetype | Behavior |
|-----------|----------|
| **The Sleeping Giant** | Passive, territorial. Wakes violently if boundaries are crossed. |
| **The Benevolent Ancient** | Open to trade and alliance. Has deep material knowledge to share. |
| **The Paranoid Relic** | Isolationist and suspicious. May strike without warning if they feel threatened. |
| **The Doomed Kingdom** | Internally collapsing. A power vacuum is coming — the question is who fills it. |
| **The Doomsday Architect** | Secretly building something. The project's nature and timeline are hidden. When it completes... |
| **The Missionary Empire** | Spreading a faith or ideology. Allies with those who convert; grows hostile to those who resist. |

Legacy Empire arcs are **not fixed fate** — they are starting conditions. A Sleeping Giant might be woken by a careless player and become a permanent threat. A Doomed Kingdom might be stabilized by shrewd diplomacy and become an ally. A Doomsday Architect can be stopped if the player discovers the threat in time and builds a coalition.

### 7.4 Power Asymmetry and Balance

Some Legacy Empires are genuinely more powerful than the player at game start. This is intentional. The design response is not to weaken them, but to give the player multiple valid strategies:

- **Avoid** — stay out of their territory; grow elsewhere
- **Ally** — find what they want; offer it
- **Contain** — build alliances with neighbors; create a defensive coalition
- **Undermine** — find their weakness (every Legacy Empire has one); exploit it slowly
- **Wait** — some Legacy Empires are already dying; patience is a strategy

If a player becomes dominant, AI factions and Legacy Empires will form coalitions against them. Dominance attracts resistance.

---

## 8. System: The Living Map (Real-Time)

### 8.1 Real-Time with Speed Controls

The game runs in continuous real-time. Nothing is turn-based. Time moves constantly, though the player can adjust the speed:

- **Pause** — full stop; give orders, review information
- **Slow** (default) — the world breathes at a walking pace
- **Normal** — the standard play speed; armies move noticeably
- **Fast** — for skipping quiet periods; risky if threats are present
- **Crisis lock** — automatically slows to Slow when a significant event occurs (attack detected, caravan intercepted, discovery made)

### 8.2 Armies on the Map

Military units are visible physical entities on the map. An army:

- Moves at a rate determined by terrain, road quality, weather, and supply
- Must be supplied (a supply chain must reach the army or it degrades)
- Leaves traces — dust, trampled grass, visible from scout units at range
- Can be intercepted, ambushed, or blocked

Sieges are not events — they are physical presences. An army surrounds a city and waits. The city's supply routes are cut. The garrison slowly degrades. The siege can be broken by a relief army.

### 8.3 The Supply Line

Armies in the field require supply. A supply line is a chain of depots, roads, and caravans connecting the army back to production centers. Cut the supply line and the army starves.

Supply management is a core strategic layer. Overextension is punished not by a game mechanic but by the physical reality of the world — your army marches too far and the food simply stops arriving.

### 8.4 Scouting and Fog of War

The player does not see the full map. Fog of war is physical — scouts reveal terrain, armies are spotted by patrol units, caravan movements may only be known if intercepted.

Intelligence is a resource. A good spy network tells you where the enemy's caravans are going. A poor one leaves you blind to a Legacy Empire mobilizing armies you didn't know existed.

---

## 9. The Core Gameplay Loop

```
EARLY GAME — The Investigation Phase
  Explore nearby territory
  Identify resource deposits
  Begin building extraction infrastructure
  Send first samples to analysis
  Make first contact with neighbors
  Observe Legacy Empires at a distance

MID GAME — The Adaptation Phase
  Properties begin revealing (through analysis and field use)
  Craft first specialized equipment from local materials
  Make strategic choices based on this world's materials
  Form or avoid alliances based on neighbor personalities
  Legacy Empire arcs begin activating
  First major conflicts over resource territory

LATE GAME — The Mastery Phase
  Deep material knowledge; alloy experimentation underway
  Complex logistics networks defending and supplying multiple fronts
  Coalition politics; managing alliance stability
  Legacy Empire arcs reaching climax
  Race to victory condition (or survival)
```

---

## 10. Victory Conditions

Multiple win conditions exist, none requiring total conquest:

**Dominion** — Control a threshold of the world's population and key resource nodes. The hardest path; triggers AI coalitions.

**Mastery** — Achieve complete material mastery (all major materials analyzed and alloyed). Scientific victory. Requires the most developed logistics and research infrastructure.

**Divine Ascendancy** — Achieve supremacy in a god's favor. The deity intervenes on your behalf in a world-altering way. Requires understanding the divine layer deeply.

**The Coalition Victory** — Successfully coordinate a multi-faction response to a Doomsday Architect Legacy Empire and stop the threat. Can be shared with allied factions.

**Dynastic Legacy** — Survive to a time threshold with your founding culture and faction identity intact. The "endurance" victory; rewards careful play over conquest.

---

## 11. Open Design Questions

These are unresolved design decisions that need answers before or during prototyping:

**~~Q1: How is the player introduced to unknown materials?~~** ✅ RESOLVED
Discovery follows a five-tier cost curve. Physical properties surface immediately through qualitative natural language. Magical properties require formal analysis. Alloy combinatorics are their own experimental layer. Faction background determines richness of early observations. See Section 5.

**Q2: How do Legacy Empire arcs telegraph themselves?** ✅ RESOLVED
Legacy Empire arcs are hidden at game start, but they are not invisible. They are telegraphed through overlapping signal clusters: diplomacy, visible behavior, world events, intelligence reports, trade patterns, border activity, religious movements, refugee flows, construction projects, and regional anomalies.

The design goal is not to make the player guess randomly. The goal is dramatic uncertainty. The player should know that something meaningful is happening, but may not immediately know what it means, how dangerous it is, or whether it is a threat, an opportunity, or both.

A single clue should rarely reveal the truth. Instead, multiple clues allow the player to narrow the possibilities over time. Experienced players may recognize patterns from previous games, but world-specific variation, incomplete information, and overlapping signals prevent perfect certainty until deeper scouting, diplomacy, espionage, or time reveals more.

Signal Categories

Legacy Empire signals can appear through several channels:

Direct diplomacy
Some empires openly communicate their intentions, or at least their stated intentions. They may issue warnings, offer gifts, demand tribute, request aid, invite religious conversion, threaten retaliation, or present themselves as protectors.

Visible behavior
The player can infer motives from what the empire physically does in the world: fortifying borders, closing roads, sending aid caravans, funding temples, stockpiling rare materials, moving armies, building strange facilities, sponsoring expeditions, or suppressing rebellions.

World events
Major developments trigger cinematic event notifications with stronger narrative framing. These events may be ominous, wondrous, confusing, celebratory, or catastrophic. The tone should match the player’s current understanding, not necessarily the full truth.

Intelligence reports
Scouts, spies, merchants, diplomats, scholars, priests, and travelers can reveal deeper clues. Investing in intelligence allows the player to distinguish surface behavior from hidden motive.

Regional consequences
Legacy Empire arcs should leave marks on the world: refugee movement, local prosperity, strange weather, religious unrest, improved harvests, disappearing caravans, magical auroras, military mobilization, or sudden changes in trade.

Overlapping Signals

Signals intentionally overlap between arc types. This creates a deduction layer inspired by games where players narrow the truth through partial evidence.

For example, rare material stockpiling could indicate:

a Doomsday Architect building a world-threatening device
a Benevolent Ancient preparing a great magical infrastructure project
a Missionary Empire constructing holy monuments
a Paranoid Relic preparing for imagined invasion
a Doomed Kingdom desperately trying to stabilize itself

The signal is meaningful, but not conclusive. The player must gather more evidence to understand the pattern.

Positive and Transformational Arcs

Legacy Empire developments do not have to be hostile. Some arcs may benefit the world or create new strategic opportunities.

Examples include:

a friendly neighbor sending food, scholars, or military aid
a magical experiment succeeding and permanently altering the world
a divine ritual restoring dead land or improving harvests
an ancient empire opening its libraries to trusted allies
a regional wonder stabilizing weather, trade, fertility, or magical flow

This prevents players from learning that every strange event is automatically bad. The world should feel alive, not merely threatening.

Benevolent Fronts and Hidden Motives

Some Legacy Empires may deliberately project benevolence as a mask. An empire might send gifts, fund public works, stabilize neighbors, or offer generous trade while secretly pursuing illicit goals.

Examples:

a Doomsday Architect funds hospitals and roads to keep neighbors complacent
a Missionary Empire provides food aid that quietly spreads religious dependence
a Paranoid Relic gives gifts to buy silence while purging internal enemies
a Benevolent Ancient is genuinely helpful in one region while exploiting another
a doomed empire hides collapse behind extravagant diplomatic generosity

The important rule is that deception must still be discoverable. A benevolent front can delay suspicion, but it should not make the truth unknowable. Contradictory signals, intercepted messages, refugee accounts, suspicious cargo, restricted zones, or intelligence reports should eventually reveal that the surface story does not fully match reality.

Wildcard Signals

To preserve replayability even for experienced players, each world may assign a limited number of wildcard signals to Legacy Empires.

A wildcard signal is a world-specific oddity that complicates interpretation without invalidating fair deduction. It may come from local culture, historical trauma, magical contamination, diplomatic masking, misinformation, or unusual world conditions.

Wildcard signals can create false leads, but they should obey three rules:

They cannot replace the core signals of an arc.
They cannot serve as the only confirmation of an arc.
They should add ambiguity, not make the game feel like it lied.

For example, a genuinely Benevolent Ancient might use heavily armed envoys because of old betrayals, making it resemble a Paranoid Relic. A Doomsday Architect might sponsor public welfare projects, making it appear benevolent until deeper investigation reveals the hidden purpose.

Design Principle

A Legacy Empire’s hidden arc should always produce visible symptoms before it produces world-changing consequences.

The player may misunderstand those symptoms. They may ignore them. They may discover the truth too late. But when the reveal comes, the player should be able to look back and think:

“The signs were there. I just didn’t know what they meant yet.”

**Q3: What is the minimum viable logistics chain?** ✅ RESOLVED
The v0.1 prototype should use the smallest logistics model that proves the core fantasy: resources are local, physical, movable, vulnerable, and strategically meaningful.

The minimum viable chain is:

[Resource Deposit] → [Extraction Site] → [Local Stockpile] → [Visible Caravan Route] → [Workshop / Forge / Research Site] → [Finished Output] → [Army, Settlement, or Project]

Several full-simulation steps are intentionally collapsed for v0.1. Surveying can be a single prospect/confirm action. Mine construction and mining operation are represented by one Extraction Site. Workers and staffing are abstracted into facility efficiency. Raw and refined materials may initially be represented as a single stockpile type. Processing and crafting can be handled by one Workshop or Forge building.

The key rule is that there is no global inventory. Resources exist at specific locations and must physically travel to where they are needed. A mine produces into a local stockpile. A route moves batches of material by visible caravan. A workshop can only use materials that have arrived at that workshop. Finished goods must then be delivered to the army, settlement, or project that needs them.

Players manage routes and priorities, not individual carts. Once a route is established, caravans should run automatically, but remain visible, vulnerable, and interruptible. Enemies can raid caravans, destroy cargo, delay production, or force the player to escort, reroute, fortify, or relocate infrastructure.

The first playable logistics scenario should include one settlement, one resource deposit, one extraction site, one workshop, one caravan route, one output, and one threat capable of disrupting the route. If that scenario creates interesting decisions, the logistics foundation works.

**Q4: How does coalition AI work?** ✅ RESOLVED
Coalitions are temporary, purpose-built alliances formed around a specific Coalition Cause. They are not permanent alliance blobs by default. A coalition forms when one or more factions identify a shared threat or opportunity that is too large to handle alone.

Common Coalition Causes include stopping a Doomsday Architect, containing a dominant player faction, resisting a Legacy Empire invasion, defending a holy site, breaking a trade monopoly, intervening in a collapsing Doomed Kingdom, or punishing repeated supply-route raiding.

A faction evaluates whether to join a coalition based on threat proximity, threat severity, relationship with the target, relationship with the coalition Convener, cultural or religious alignment, existing obligations, expected reward, expected cost, and strategic opportunism.

Coalition members do not all contribute the same way. A member may send armies, food, money, rare materials, intelligence, military access, specialists, priests, scholars, engineers, or spies. This allows weak or distant factions to participate meaningfully without always committing troops.

Coalitions have Cohesion, representing trust, shared urgency, morale, and willingness to continue cooperation. Cohesion rises when the threat escalates, members honor commitments, the coalition wins, or the target behaves aggressively. Cohesion falls when the war drags on, members suffer heavy costs, promises are broken, rivalries flare, the threat weakens, or members are offered separate deals.

Coalitions remain intact while the shared cause feels more important than internal disagreements. They fragment when cost, distrust, rivalry, success, or changing circumstances make cooperation less attractive.

For v0.1, coalition AI should be lightweight. Each coalition needs a Cause, Target, Convener, Members, Cohesion, Urgency, and Goal. Each faction evaluates a small set of factors to decide whether to join and chooses one primary contribution type: Military, Supply, Money, Intelligence, Access, or Refuse.

**Q5: What is the "just one more minute" hook in real-time?** ✅ RESOLVED

AXIOM's real-time hook comes from anticipation rather than constant action. The player is always waiting for something meaningful to arrive, finish, reveal, deteriorate, or collide.

The main anticipation hooks are discovery timers, visible movement, escalating event chains, logistics friction, strategic windows, and controlled crisis bursts.

Material analysis, scouting expeditions, alloy experiments, divine omens, and field discoveries create pending reveals. Caravans, armies, envoys, refugees, and suspicious convoys create visible movement across the map. Legacy Empire arcs and world events escalate through stages, giving the player partial information before major consequences arrive. Logistics creates suspense because resources, equipment, and supplies must physically reach their destination before plans can continue.

The player should often be thinking: "I'll just wait until this sample is analyzed," "I'll just see if that caravan arrives," "I'll just watch where that army is going," or "I'll just resolve this event chain before stopping."

The game should also create temporary strategic windows: a distracted empire, an exposed supply route, a rare weather event, a fragile coalition, a rebellion, or a brief opportunity to act before conditions change.

The hook should not rely on constant unit micro, rapid combat execution, or endless minor notifications. AXIOM should feel tense because the world is moving and consequences are approaching, not because the player is forced to click quickly.

**Q6: How granular is staffing?** ✅ RESOLVED

Staffing uses a two-layer model: population provides labor, while specialists provide identity, expertise, and drama.

Ordinary facility labor comes from settlement or regional population pools. The player does not assign individual workers manually. Instead, the player sets labor priorities across broad categories such as food, mining, construction, research, military recruitment, and logistics. Facilities can be staffed, understaffed, or idle depending on available labor and priority.

Specialists are rare named or semi-named characters who can be assigned to important facilities, projects, armies, diplomacy, espionage, or research. Examples include master smiths, scholars, mages, priests, caravan captains, engineers, diplomats, spies, alchemists, and road wardens.

Labor determines whether a facility functions. Specialists determine how well, how safely, or how intelligently it functions. A forge can operate with ordinary labor, but a master smith may improve equipment quality or reveal material flaws faster. A research site can analyze samples with ordinary scholars, but a brilliant mage may uncover magical properties more quickly or interpret ambiguous results better.

Specialists should be rare enough that assignment creates meaningful tradeoffs. Sending a master smith to a frontier forge may improve rare-material production, but exposes them to raids, capture, assassination, or poaching.

For v0.1, staffing should be lightweight: settlements have labor pools, facilities consume labor, the player sets broad priorities, and one specialist may optionally be assigned to one important facility. Full character-level drama, families, inheritance, personal relationships, and court simulation remain out of scope for the initial prototype.

The design goal is strategic scarcity and narrative attachment, not labor micromanagement.

**Q7: What does the map look like?** ✅ RESOLVED

AXIOM should use a region-node map for v0.1, with free-form visual terrain layered underneath. The world should look like an organic fantasy map, but the underlying simulation should be built from connected regions, settlements, roads, resource sites, passes, rivers, ruins, and chokepoints.

The player should think in terms of meaningful places rather than individual tiles. Regions can contain settlements, resource deposits, holy sites, ruins, terrain traits, magical anomalies, roads, forts, armies, and caravan routes.

Movement should be route-based. Armies, caravans, envoys, refugees, and scouts physically travel along roads, passes, rivers, or rough terrain paths. This supports the logistics pillar by making distance, chokepoints, ambushes, escorts, and supply disruption visible and strategically important.

Territory control should primarily happen at the region and settlement level. A faction may control a settlement while the surrounding region remains contested, unsafe, or only partially influenced. Roads and resource sites can have separate security or control states, allowing raiding and logistics warfare without requiring full conquest.

The game should avoid showing a visible hex grid for the main strategic map. Hexes are clear and useful for prototyping, but they risk making the world feel too board-game-like. A hidden grid, graph, or navmesh may still exist under the hood, but the player-facing map should feel like a living world rather than a board.

For v0.1, the map should be small: one player capital, one nearby settlement, one resource deposit, one workshop or forge, one academy or research site, one dangerous route or pass, one hostile camp or rival faction, one Legacy Empire border region, and roughly 5–8 connected regions total.

The design goal is a map that is physical and readable, but not tile-fiddly: a living strategic space where places, routes, and chokepoints matter.

---

## Future System: Tactical Battles

Although the v0.1 prototype may simulate combat abstractly or use a minimal tactical encounter, the long-term vision is for intercepted caravans, army clashes, raids, and sieges to resolve through squad-scale tactical battles inspired by Final Fantasy Tactics.

Tactical battles pause the real-time strategic world and resolve turn-by-turn on a dedicated tactical map. When the battle concludes — by route, defeat, or negotiation — control returns to the strategic map with results applied: cargo delivered or stolen, guards injured or killed, raiders defeated or fled, material properties discovered through field use.

Tactical battles should emphasize attachment to persistent squads rather than disposable generic units. Squads may eventually have names, banners, liveries, equipment, veteran traits, injuries, reputations, and material-based gear effects. Squad members are mortal — they can be killed, seriously injured, or captured. Those outcomes feed back into the strategic layer and are permanent. This is what makes the attachment real.

The tactical map uses a grid-based 2D perspective with isometric or top-down presentation, consistent with the game's overall visual style. The exact presentation is a later decision, but the underlying simulation should be grid-based from the start. Early implementation should use a small grid with two elevation levels — Low and High. Elevation affects movement, line of sight, range, attack advantage, and terrain access. This preserves the strategic value of height without requiring full 3D terrain simulation.

For v0.1, tactical combat is not required to be fully developed. The first combat test should be a small caravan interception scenario where the result feeds back into the overworld: cargo delivered, cargo stolen, guards injured, raiders defeated, or material properties discovered through field use.

---

## 12. Out of Scope (For Now)

Features intentionally deferred to avoid scope creep on the initial prototype:

- **Multiplayer** — The long-term vision is slow async multiplayer (days-per-move style). Not in v1.
- **Full Divine/Cult System** — Deities exist in v1 as world flavor and passive influence. Active cult mechanics are a later layer.
- **Character-level drama** — Named rulers, marriage, inheritance (CK3-style) are a possible future system but not core to v1.
- **Naval systems** — Sea movement, naval logistics, island territories.
- **Full diplomacy treaty system** — v1 diplomacy can be simple (ally/neutral/hostile). Deep treaty mechanics come later.

---

*Document status: Living draft — all v0.1 design questions resolved; discovery-first prototype thesis, raider pressure, and counterplay model added.*

---

## 13. Prototype Scope Definition — Discovery-First v0.1

All seven open design questions are resolved. The v0.1 prototype has a clear, buildable scope. This section defines the first playable slice more sharply: the prototype exists to prove that discovering, adapting to, and harnessing a strange material can become the core fun loop of AXIOM.

### 13.1 Prototype Thesis

The first playable prototype should make the player think:

> I found something strange. I do not fully understand it yet. I need to claim it, move it, study it, and decide how to use it before the world reacts.

Discovery is the star of v0.1. Logistics, threats, equipment, research, and combat exist to make discovery matter. The prototype should not primarily test empire management, diplomacy, divine systems, tactical battle depth, or full AI competition. Those systems should remain lightweight unless they directly reinforce the discovery loop.

The prototype's core emotional target is curiosity under pressure. The player should feel that the world contains hidden rules, that incomplete knowledge still supports useful reasoning, and that adapting to this world's specific material properties can create a strategic advantage.

### 13.2 Core Prototype Loop

The v0.1 loop is:

1. **Discover** a strange ore deposit.
2. **Claim** the mine before another actor exploits it.
3. **Extract** enough ore for a first meaningful use.
4. **Transport** ore by visible caravan to the settlement, forge, or academy.
5. **Choose** whether to forge immediately or delay for testing/research.
6. **Commit** scarce ore to weapons or armor.
7. **Use** the equipment in a route defense, raid, or field test.
8. **Learn** a material property through testing, analysis, or field discovery.
9. **Adapt** the player's strategy based on what the material is actually good at.

The player should not be able to solve the scenario by memorizing a universal build order. The optimal path should depend on what the prototype material turns out to be and how the local pressure develops.

### 13.3 Primary Random Axis

The primary random axis for v0.1 is **material properties**.

The first prototype does not need many random systems. It needs one strange material whose properties are partially hidden, strategically relevant, and discoverable through multiple paths. Terrain, deities, Legacy Empire arcs, and rival personalities may provide light flavor or scenario modifiers, but they should not compete with material discovery as the main prototype focus.

The first material should support at least three knowledge states:

- **Observed:** The player can see qualitative traits immediately.
- **Tested:** The player can learn practical physical behavior through workshop testing.
- **Proven:** The player can discover a combat-relevant property through field use or academy analysis.

Example structure:

- Tier 1 observation: *"The ore is reddish, unusually dense, and warm to the touch."*
- Tier 2 practical test: *"Harder than common iron, but brittle under sudden impact."*
- Tier 3 or field discovery: *"The ore stores heat and resists flame."*

The exact material can change between prototype runs, but each run should produce a readable path from observation to adaptation.

The prototype should explicitly teach the player that materials are not fixed recipes. If the same placeholder ore appears in multiple prototype runs, the player should understand that this world's version may not behave like the last world's version. This is a core distinction from most strategy games and should be communicated early through tutorial copy, faction dialogue, or the Material Codex.

### 13.4 Systems-Driven Material Model

Long-term, material identity should come from underlying systems rather than from hand-authored bonuses such as "+10% weapon damage."

Each material should be generated from a shared set of physical qualities. These qualities can be represented internally as sliders, ranges, or ratings. The player does not see the raw numbers at first; they see qualitative descriptions that point toward the hidden values.

Potential physical qualities include:

- **Hardness** — resistance to scratching, cutting, or deformation
- **Density / weight** — heaviness, transport burden, armor encumbrance, impact force
- **Toughness** — ability to absorb force without failing
- **Brittleness** — tendency to crack, shatter, or fail under sudden impact
- **Edge retention** — ability to hold a sharp cutting edge
- **Malleability / workability** — ease of forging, shaping, repairing, or alloying
- **Flexibility / elasticity** — bending, rebounding, bow-making, shock absorption
- **Conductivity** — heat, cold, lightning, magic, or other energy transfer
- **Thermal resistance** — ability to withstand fire, cold, rapid temperature change, melting, ignition, or heat transfer
- **Heat retention / dissipation** — whether a material stores heat, sheds heat quickly, self-cools, or becomes dangerous after exposure
- **Corrosion / decay resistance** — durability against weather, rot, poison, acid, or time
- **Resonance** — tendency to ring, vibrate, hum, echo, amplify, or sympathetically react to physical, magical, emotional, or ritual forces
- **Appeal** — cultural, aesthetic, morale, trade, prestige, fear, or religious value

Many properties that first sound like magical tags can instead be continuous sliders. Fire resistance is a good example: a material may be slightly fire-resistant, highly fire-resistant, heat-absorbing, heat-reflective, slow to ignite, unable to ignite, prone to heat buildup, or resistant to flame but vulnerable to sudden temperature shock. For v0.1, thermal resistance should be treated as a slider-style physical quality rather than a simple binary tag.

Magical properties can still be layered on as tags or conditional traits when they represent exceptional behavior rather than ordinary material variation. Examples include levitation, magic amplification, healing resonance, undead toxicity, divine attunement, void contamination, animal agitation, temporal instability, dream influence, ancestor resonance, or force rebound.

**Resonance definition:** resonance should not mean a generic magic bonus. It means the material has a tendency to respond strongly to certain kinds of force, sound, ritual, emotion, or magic. In mundane form, high resonance might mean a blade screams when struck, armor hums under impact, bells carry farther, or shields transmit shock poorly. In magical form, resonance might make a material amplify spells, react to divine rites, disturb animals, frighten enemies, synchronize with nearby artifacts, or reveal hidden properties during battle. Resonance is useful because it can create weird world-specific behavior without becoming a flat stat bonus.

For v0.1, resonance is optional. It can appear as a qualitative clue — for example, *"the ore rings sharply when struck"* — but the prototype should focus primarily on thermal resistance, hardness, toughness, brittleness, weight, edge retention, and workability.

Equipment performance should be derived from these underlying properties and the equipment form. For example:

- High hardness + high edge retention + manageable brittleness suggests strong blades.
- High density + high toughness suggests armor or blunt impact tools, but may reduce mobility.
- High brittleness may make a material poor for long weapons but useful as flakes, arrowheads, inlays, or brittle traps.
- High thermal resistance may matter more for shields, armor, gates, caravans, and siege defense than for swords.
- High resonance may matter for morale, ritual equipment, magic amplification, fear effects, unusual field discoveries, or specialized weapons, depending on what kind of resonance the material expresses.
- High appeal may make a material valuable for diplomacy, prestige troops, religious offerings, or intimidation even if its combat properties are mediocre.

For v0.1, the implementation can use a small set of prebuilt property bundles to keep scope controlled. However, those bundles should be treated as examples of slider/tag rolls, not as fixed authored identities. The prototype material may still have readable tendencies like "blade-favored," "armor-favored," "split-use," or "research-favored," but those tendencies should emerge from hidden physical qualities and magical tags.

Design principle:

> Materials should not be lists of explicit bonuses. Materials should be generated substances whose observed behavior, tested properties, and field performance imply what they are good for.

### 13.5 Prototype Magical Property Layer

For v0.1, magical properties should exist, but they should be restrained and readable. The prototype does not need exotic magical behaviors like levitation, time distortion, dream influence, divine possession, or terrain reshaping. Those can wait until later.

The first prototype should support a small set of straightforward magical effects that are easy to understand, hard enough to discover, and useful for the weapons-vs-armor decision:

1. **Elemental response**  
   A material may resist, absorb, conduct, amplify, or suffer from elemental forces. Fire resistance is the clearest v0.1 example because the prototype can easily create situations where fire matters: raider firebombs, burning barricades, forge accidents, scorched roads, or settlement defense.

2. **Elemental weakness**  
   Magical behavior should include drawbacks as well as benefits. A material might be resistant to fire but dangerously conductive to lightning, strong against heat but brittle after cold shock, or protective against flame while trapping heat against the wearer.

3. **Attribute influence**  
   A material may subtly affect those who wear, wield, or carry equipment made from it. Prototype-safe examples include strength, endurance, fatigue, speed, morale, steadiness, fear, or aggression. These should be expressed as qualitative battlefield or event outcomes, not as obvious item text like "+10% strength."

4. **Delayed weird property**  
   Each prototype run may include one harder-to-discover magical property that does not reveal from basic observation. It should require Tier 3 academy analysis, repeated field use, or a dramatic combat event. For v0.1, this delayed weird property should still be simple enough to explain: elemental resistance/weakness, physical attribute enhancement, physical attribute drain, morale influence, or fatigue behavior.

Magical properties should be implemented as **underlying behaviors**, not explicit item bonuses. A material should not say "Redglass Armor grants +10% fire resistance." Instead, the game should surface discoveries through natural language, testing, and events:

- *"The plating blackened under flame, but did not soften."*
- *"Soldiers carrying Redglass shields report unusual heat buildup after long exposure."*
- *"During the raid, militia wielding Redglass blades struck with surprising force, but tired quickly afterward."*
- *"Academy scholars believe the ore resonates with muscular exertion, increasing short bursts of strength at a physical cost."*

For v0.1, the material model should distinguish between ordinary physical sliders and magical response sliders. Fire behavior may be partly physical and partly magical. The player does not need to know the category immediately; they only need to learn how the material behaves.

Minimum v0.1 magical set:

- **Thermal response** as a slider-style property: fire resistance, fire weakness, heat absorption, heat buildup, heat shedding, ignition resistance, or thermal shock vulnerability.
- **One attribute effect** as a hidden delayed property: strength, endurance, fatigue, speed, morale, or fear influence.

Design principle:

> Prototype magic should be understandable in effect but mysterious in cause. The player should discover what the material does before they fully understand why it does it.

### 13.6 Hybrid Discovery Progress Model

For v0.1, delayed magical properties should be discovered through a hybrid of research and field use. The prototype does not need a full experimental science system yet. Instead, each hard-to-identify property can have an internal **discovery progress** value.

Research and field use both add to the same hidden progress value:

- **Academy research** adds steady, controlled progress. It may produce vague warnings, partial theories, or safe-use recommendations before the property is fully understood.
- **Field use** adds practical progress when equipment made from the material is exposed to relevant stress: combat, fire, fatigue, fear, impact, long marches, or crisis events.
- **Major dramatic events** may add a larger amount of progress, especially if the hidden property clearly manifests during battle or logistics pressure.

When discovery progress crosses a threshold, the Material Codex updates with a clearer description of the property. This allows the prototype to support mystery without requiring complex lab interactions.

Example progression:

1. **0% known:** *"Scholars detect an unusual response under stress, but cannot explain it."*
2. **Partially known:** *"The ore appears to interact with exertion or heat. Further observation required."*
3. **Mostly known:** *"Redglass equipment seems to increase short bursts of strength, but accelerates fatigue."*
4. **Codex entry complete:** *"Redglass resonates with muscular exertion. Weapons and armor made from it can enhance violent physical effort for a short time, but prolonged use exhausts the wearer."*

This model supports the chosen prototype tradeoff:

- Forging quickly may reveal properties through danger and field use.
- Waiting for research may reveal safer clues before commitment.
- Combining both produces the clearest understanding.

For the prototype, the player does not need to see a visible numeric progress bar. The underlying number can drive event timing and Codex updates while the interface communicates progress narratively through notes, warnings, and observations.

Later expansions can replace or deepen this model with targeted testing. Examples include blasting ore with fire, freezing it, striking it with different weapons, exposing it to divine ritual, marching soldiers in it, testing fatigue under load, or comparing forged forms. Those systems should build on the same principle: different kinds of evidence reveal different aspects of material behavior.

Design principle:

> Research and field use should contribute to the same understanding. The player can learn safely, learn dangerously, or combine both approaches.

### 13.7 First Strategic Equipment Decision

The first major player decision should be:

> Do I spend the first scarce batch of strange ore on weapons, armor, or research before committing it?

The player should initially have enough ore for one meaningful equipment order, not everything. This creates a concrete adaptation fork.

**Forge weapons now** gives immediate offensive power. It may help the player attack a raider camp, repel an early raid, or create a decisive first strike. The risk is that the material may later prove brittle, unstable, poorly suited to blades, or better used defensively.

**Forge armor now** gives immediate defensive power. It may protect caravan guards, mine workers, or settlement militia. The risk is that the material may later prove too heavy, reactive, vulnerable to blunt force, or better used offensively.

**Wait for testing or research** gives better information and may unlock a superior use case, but costs time while other actors move. Waiting should be valid but not automatically correct.

The design rule is:

> Quick forging gives immediate imperfect power and possible field discovery. Research gives safer knowledge and better crafting decisions, but sacrifices initiative.

### 13.8 Equipment Derivation Model

Weapons and armor should not receive fixed material bonuses such as "+10% damage" or "+15 fire resistance" as intrinsic traits of the ore. Equipment performance should be derived from the interaction between four things:

1. **Material properties** — hidden physical sliders, elemental response sliders, and delayed magical effects.
2. **Equipment form** — blade, spearhead, mace head, shield, helmet, breastplate, mail reinforcement, gate plating, or other use case.
3. **Crafting process** — rushed forging, practical-tested forging, academy-informed forging, specialist forging, or later alloy treatment.
4. **Battle context** — enemy weapons, attack type, terrain, weather, fire use, morale conditions, and unit role.

The same material may be excellent in one form and poor in another. A hard, brittle, edge-holding material may be dangerous as a blade edge but unreliable as full armor. A dense, tough, heat-resistant material may be excellent as shield plating but too heavy for swords. A magically strength-reactive material may favor shock troops but exhaust scouts or caravan guards over long marches.

For v0.1, the prototype does not need precise formulas exposed to the player. Internally, however, equipment should be evaluated through qualitative fit categories rather than hard-coded identities.

Recommended v0.1 fit categories:

- **Poor fit** — the material works against the equipment form; use is possible but risky or inefficient.
- **Usable fit** — the equipment functions normally, with minor advantages or drawbacks.
- **Strong fit** — the material clearly supports that equipment form and creates a meaningful tactical or strategic advantage.
- **Exceptional / strange fit** — the material produces an unusual result, likely involving delayed magic, elemental behavior, morale impact, or field discovery.

The player should experience these categories through natural language, event results, and observed outcomes, not raw stat labels.

Examples of derived outcomes:

**Hardness + edge retention + brittleness** may produce blades that are frighteningly sharp but prone to chipping in long fights. This favors ambushes, first strikes, and aggressive raids rather than prolonged defense.

**Toughness + density + thermal resistance** may produce heavy shield plating that protects caravan guards from firebombs and arrows but slows movement and increases fatigue on long escorts.

**Workability + balanced toughness + moderate weight** may produce reliable militia equipment with no dramatic surprise, making it a safe but less transformative choice.

**High thermal absorption + poor heat shedding** may protect against immediate flame but become dangerous in prolonged exposure, creating delayed fatigue, panic, or injury events.

**Delayed strength resonance** may make wielders strike harder during combat, but only after field use reveals the effect. The same property may be beneficial on weapons, questionable on heavy armor, and harmful for scouts or laborers if it causes exhaustion.

Practical testing should improve the player's prediction of physical fit. Academy analysis should improve prediction of magical or elemental fit. Field use should reveal the most contextual properties — especially effects that only appear under heat, fear, injury, exertion, divine influence, or battle stress.

The first prototype equipment decision should therefore be derived like this:

1. The player discovers the ore and receives Tier 1 descriptive clues.
2. The player may rush forging, run practical tests, or send a sample to the academy.
3. The material's hidden properties determine whether weapons, armor, or delayed research is likely to be the best first use.
4. The forge output receives a qualitative expectation such as "promising blade material, but brittle" or "heavy but reliable shield plating."
5. The first raider conflict tests that choice in context.
6. Combat results may reveal a field note that updates the Material Codex.

Design principle:

> Equipment should be the visible expression of material behavior. The ore does not say "weapon bonus" or "armor bonus." The player learns what it is good for by observing, testing, crafting, and surviving the consequences.

### 13.9 Prototype Pressure Model

For v0.1, pressure begins when the strange ore is discovered.

Discovery should not be a passive notification. It should change the local world state. Once the deposit is found, the player is pressured to claim the site, establish extraction, move the ore, study or forge it, and follow through on a strategic use before other actors react.

The first pressure source should be local and diegetic rather than abstract. The prototype may use timers, but those timers represent visible world activity, not generic enemy scaling.

Example pressure chain:

1. **Ore discovered:** scouts or prospectors find a strange deposit near a contested route.
2. **Local interest rises:** smoke, workers, rumors, or survey markers reveal that something valuable may exist there.
3. **Other actors notice:** raiders, a rival faction, or border scouts begin watching the area.
4. **Claim race begins:** if the player delays, another actor may reach the mine, spy on it, steal a sample, raid the workers, or shadow the first caravan.
5. **First commitment:** the player must choose whether to rush extraction, escort the caravan, send a sample to the academy, or immediately forge weapons/armor.
6. **Consequence:** the player's choice determines whether they enter the first conflict informed, under-equipped, well-defended, offensively prepared, or strategically delayed.

The prototype threat can be a known incoming raid or interception attempt, but its purpose is not to create a universal ticking clock. It represents an actor responding to opportunity.

Design principle:

> Pressure should be local, diegetic, and actor-driven. The prototype may use preparation windows, but long-term AXIOM pressure comes from a living asymmetric world, not from abstract difficulty scaling.

### 13.10 Raider Pressure Logic

For v0.1, the prototype pressure actor is a local raider band. The raiders do not need deep diplomacy or strategic AI. Their role is to test whether the player's discovery, logistics, and equipment decisions create meaningful pressure.

Raiders become interested after the strange ore deposit is discovered. Their behavior should be opportunistic rather than scripted. They look for exposed value in the local supply chain.

Primary raider targets:

1. **Ore caravans**  
   If the player begins transporting ore from the mine to the settlement, forge, or academy, raiders may shadow the route and attempt to intercept the first meaningful shipment.

2. **Mine stockpiles**  
   If extracted ore piles up at the mine and no caravan moves it away, raiders may raid the mine directly, especially if the site is lightly guarded.

3. **Under-guarded routes**  
   If the player repeatedly sends unescorted or lightly guarded caravans through dangerous territory, raiders become more likely to attack along that road.

4. **Visible military preparation**  
   If the player begins forging weapons or armor from the ore, raiders may become more aggressive because they recognize the player is turning the discovery into military advantage.

The raider logic should communicate warnings before major punishment. The player may see scout sightings, missing workers, campfire smoke near the pass, rumors from travelers, or a "route being watched" alert.

The design goal is not to surprise-punish the player. The goal is to make the player think:

> The ore is valuable, and the world has noticed. I need to move it, guard it, hide it, spend it, or accept the risk.


### 13.11 Raider Counterplay and Attention Model

For v0.1, the player should have three clear forms of counterplay against raider pressure:

1. **Guard** — assign guards to the mine, escort caravans, or increase local route security.
2. **Scout** — send scouts to the dangerous pass or watched road to reveal raider movement before an attack.
3. **Move quietly** — reduce obvious exposed value by limiting activity, moving smaller shipments, or preventing ore from piling up at the mine.

True stealth, concealment, decoys, bribery, and misdirection are strong long-term systems, but they are not required for the first playable prototype. For v0.1, concealment can be modeled indirectly through **local attention**.

Each important site or route can track a simple qualitative attention state:

- **Quiet** — little activity; raiders may not know the site is valuable.
- **Noticed** — signs of activity have been seen; raider scouts may appear.
- **Watched** — raiders are monitoring the route or mine; warning events become likely.
- **Targeted** — raiders have identified exposed value and may raid the mine or intercept a caravan.

Attention rises when the player creates visible activity over time. Examples include establishing extraction, running the mine continuously, letting ore stockpiles grow, sending repeated caravans, moving large shipments, leaving valuable cargo under-guarded, visibly forging military equipment, or building obvious infrastructure around the deposit.

Attention should not function as a generic alarm meter that punishes all progress. It represents other actors noticing evidence in the world: smoke, cart tracks, rumors, hired labor, supply purchases, road traffic, guard rotations, campfires, and gossip.

The player can manage attention by:

- moving ore before large stockpiles form
- sending smaller or less frequent shipments
- escorting valuable caravans
- guarding the mine while ore accumulates
- scouting the pass before committing a shipment
- temporarily pausing extraction if the site becomes too exposed
- rushing a first small shipment before the raiders fully understand its value

For v0.1, the design goal is not a stealth game. The goal is to make activity itself meaningful. The longer the player extracts, stores, and moves rare material in a contested area, the more likely it is that someone notices.

Design principle:

> Activity creates evidence. Evidence creates attention. Attention creates pressure.

### 13.12 Long-Term Pressure Direction

Post-prototype, pressure should usually exist from the start of a campaign to varying degrees. It should emerge from the generated world's actors, geography, divine moods, scarcity, agendas, and asymmetries.

Possible long-term pressure sources include:

- aggressive neighbors probing borders or resource claims
- passive neighbors who ignore the player unless provoked
- raiders responding to exposed supply routes
- deities shaping risks, blessings, taboos, or sacred geography
- Legacy Empires pursuing hidden arcs on their own timelines
- rival scholars, merchants, or spies trying to obtain samples
- weather, seasonal windows, road conditions, and logistics failures
- local factions reacting to visible extraction, fortification, or militarization

The important distinction is that pressure is not a balancing lever. The world is allowed to be unfair, quiet, explosive, generous, hostile, or strange. The player survives by understanding the current world and adapting to it.


### 13.13 First Prototype Map

The first playable map should be a small handcrafted region-node graph. Procedural map generation can wait. The prototype map's job is to prove the discovery/logistics/threat loop with as few places as possible.

The map should contain **seven regions**:

1. **Hearthmere** — player settlement  
   The player's starting town. Contains the local stockpile, forge/workshop, academy/research action, militia, labor pool, and core UI/tutorial prompts. Most early ore is ultimately brought here to be studied or forged.

2. **Redglass Foothills** — strange ore deposit / future mine  
   The discovery site. Starts as a strange deposit, then becomes a claimed extraction site after the player commits labor and time. Produces ore into a local mine stockpile. If ore piles up here without guards or transport, raiders may target the mine directly.

3. **Ashen Pass** — short dangerous route  
   The fastest route between Hearthmere and the Redglass Foothills. It is the obvious path for early caravans, but it is exposed to raider scouting and ambushes. This is the primary pressure route.

4. **Old Pine Road** — longer quieter route  
   A slower alternate route from the Redglass Foothills back toward Hearthmere. It should be safer or less watched at first, but costs more travel time. This gives the player a simple routing choice without requiring a full logistics network.

5. **Westmere Farms** — safe support region  
   A nearby player-controlled or friendly region that connects Hearthmere to the Old Pine Road. Provides food/labor flavor, a safe staging area, and a place for basic scout or guard assignment. It helps make the world feel less like a single line of nodes.

6. **Blackbanner Camp** — local raider presence  
   The source of prototype pressure. It does not need full faction AI. It can begin partially hidden, rumored, or visible as a hostile camp near Ashen Pass. Its purpose is to watch exposed value, raid under-guarded mine stockpiles, intercept caravans, or steal samples if the player delays.

7. **The Silent Border** — distant Legacy Empire edge  
   A mostly inactive border region that hints at the larger AXIOM world. It should not drive v0.1 gameplay. It exists to establish tone: the local ore dispute is happening in the shadow of larger asymmetric powers. The region may generate flavor warnings, distant patrol sightings, or future-facing event text, but should not distract from the prototype loop.

#### Suggested Region Connections

The first graph should be readable at a glance:

```text
               [The Silent Border]
                      |
[Blackbanner Camp] -- [Ashen Pass] -- [Hearthmere]
        |                  |              |
        |          [Redglass Foothills]   |
        |                  |              |
        +---------- [Old Pine Road] -- [Westmere Farms]
```

Core route options:

- **Fast dangerous route:** Redglass Foothills → Ashen Pass → Hearthmere
- **Slow quieter route:** Redglass Foothills → Old Pine Road → Westmere Farms → Hearthmere
- **Threat route:** Blackbanner Camp → Ashen Pass or Redglass Foothills
- **Future flavor route:** Hearthmere or Redglass Foothills → The Silent Border

The map should not show a visible hex grid. It should look like an organic fantasy map with roads, passes, hills, fields, and borders, while the simulation underneath uses the region-node graph.

#### Starting Map State

At scenario start:

- Hearthmere, Westmere Farms, and the rough location of the Redglass Foothills are known.
- The ore deposit is discovered early through a scout/prospector event.
- Ashen Pass is known as the fastest route but has a dangerous reputation.
- Old Pine Road is known as slower and less trafficked.
- Blackbanner Camp may begin as a rumor, smoke sighting, or unknown hostile presence rather than a fully identified camp.
- The Silent Border is visible but mostly inactive.

The player should not be confused about where to go. The mystery should come from the ore's properties and the raiders' timing, not from basic map navigation.

#### Map State Variables

Each region should track only a few prototype-safe values:

- **Owner / influence:** player, neutral, raider, Legacy border, contested, or unknown
- **Security:** safe, guarded, risky, watched, or hostile
- **Attention:** quiet, noticed, watched, or targeted
- **Stockpiles:** local material quantities, especially ore at the mine and settlement
- **Facilities:** settlement, mine, forge/workshop, academy/research action, camp, or watchpost
- **Units / actors present:** militia, guards, scouts, caravans, raider scouts, raider party
- **Active events:** discovery, route watched, caravan preparing, raid warning, analysis complete

Do not add more region simulation until these values produce interesting decisions.

#### Why This Map Works

This map supports the core v0.1 decisions:

- Claim the Redglass Foothills quickly or delay for caution.
- Mine ore continuously or pause to reduce attention.
- Move a small early shipment or wait for a larger load.
- Take the fast dangerous route or the slow quieter route.
- Guard the mine, escort the caravan, scout Ashen Pass, or invest in research/forging.
- Send ore to the academy, forge weapons, or forge armor.
- Learn from research, field use, or both.

The map also keeps AXIOM's larger identity visible without requiring large systems. The Silent Border implies Legacy Empires. Ashen Pass and Old Pine Road imply logistics choices. Blackbanner Camp implies actor-driven pressure. Redglass Foothills anchors discovery.

Design principle:

> The first map should be small enough to understand immediately, but physical enough that every decision has a place, a route, and a consequence.

### 13.14 Updated v0.1 Build Scope

**Map:** Seven-region handcrafted region-node graph: Hearthmere, Redglass Foothills, Ashen Pass, Old Pine Road, Westmere Farms, Blackbanner Camp, and The Silent Border. Organic visual terrain, route-based movement, no visible hex grid.

**Factions:** One player faction, one local raider actor, one distant Legacy Empire border presence. The raider band does not need full strategic AI; it only needs enough behavior to notice exposed ore value, watch routes, raid mine stockpiles, intercept caravans, or steal samples from the discovered ore site.

**Logistics chain:** Deposit → Extraction Site → Local Stockpile → Caravan Route → Workshop/Forge or Research Site → Output → Destination. No global inventory.

**Discovery:** Tier 1 immediate observation, Tier 2 practical testing, and one simple Tier 3 academy analysis. Field discovery appears as event notifications after equipment is used. The first material should be driven by hidden physical qualities, elemental response sliders, and one delayed magical attribute effect, with the player seeing qualitative descriptions rather than raw stats.

**Equipment fork:** The first scarce ore batch can be committed to weapons, armor, or research delay. Weapons and armor should produce different strategic postures because of the material's generated physical sliders, elemental responses, equipment form, crafting process, battle context, and delayed magical behavior, not because of fixed hard-coded bonuses.

**Staffing:** Settlement labor pools with broad priority sliders. One specialist slot per major facility, or one starting specialist who can improve either forging, testing, research, or caravan safety.

**Threat/pressure:** Ore discovery triggers local raider interest. The player is pressured to claim, extract, move, study, and use the ore before raiders interfere. Raiders primarily threaten ore caravans and mine stockpiles, with risk increasing when value is visible and under-guarded.

**Counterplay:** The player can guard, scout, or move quietly. For v0.1, moving quietly is represented by an activity-based attention model rather than a full stealth system. Longer activity, larger stockpiles, repeated shipments, and visible military preparation raise attention; smaller shipments, scouting, escorts, guards, or paused extraction help manage risk.

**Coalition AI:** Out of scope for the first playable prototype unless represented as a simple event or future-facing hint.

**Real-time:** Continuous with pause and speed controls. Crisis events auto-slow to minimum speed. The real-time hook should come from waiting for samples, caravans, tests, and threats to resolve.

**Combat:** Abstract result screen for v0.1 unless a small tactical test is cheap to implement. Combat must be able to trigger field discovery.

**The test:** One settlement, one strange ore deposit, one mine, two route choices, one forge/workshop, one academy or research action, one equipment fork, and one local raider actor capable of contesting the ore chain. If the player feels curiosity, pressure, and adaptation from that scenario, the foundation works.

### 13.15 Next Design Questions

The next unresolved prototype questions are:

1. What exact warning signals and UI alerts tell the player the local attention state has changed?
2. What are the first five buttons the player clicks?
3. What does the first 10-minute player flow look like from ore discovery to first commitment?
4. What ends the prototype scenario?
5. What information appears in the Material Codex after each discovery step?

*Recommended next session: define the first five player actions and the first 10-minute flow — from ore discovery, to claim, to extraction, to route choice, to research or forging commitment.*
