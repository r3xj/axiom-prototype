# Game Design Document
## *Working Title: AXIOM* — Fantasy Grand Strategy
**Version 0.61 — Solo Developer Execution Plan Added**

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

*Document status: Living draft — v0.1 prototype scope updated with population-rooted economy, manpower loss, supplies, starting asset model, labor assignment friction, time-only wounded recovery, first squad creation flow, relative squad strength targets, implementation phasing, Phase 1 non-combat implementation details, Phase 1 non-combat material payoffs, and Phase 2 raider UX flow.*

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

- Tier 1 observation: *"The ore appears as a reddish, glassy seam in the foothills. Local miners do not recognize it."*
- Tier 2 practical test: *"Samples are difficult to shape. Early tests suggest one promising equipment use, but not enough to explain the ore fully."*
- Tier 3 or field discovery: *"Under flame stress or battlefield use, equipment made from the ore reveals an unusual thermal behavior."*

The exact material can change between prototype runs, but each run should produce a readable path from observation to adaptation.

The prototype should explicitly teach the player that materials are not fixed recipes. If the same placeholder ore appears in multiple prototype runs, the player should understand that this world's version may not behave like the last world's version. This is a core distinction from most strategy games and should be communicated early through tutorial copy, faction dialogue, or the Material Codex.

#### Early-Clue Ambiguity Rule

Initial material descriptions should create curiosity and hypotheses, not reliable solutions.

The player should not be able to look at the first description of an ore and immediately infer the correct use case. If the first line says the ore is warm, heavy, glassy, or resonant, experienced players will quickly learn to treat those words as encoded stat hints. That works against AXIOM's core promise that each world has new rules.

For v0.1, Tier 1 observations should usually be restrained. They can tell the player that something is unusual, local, valuable-looking, or worth investigating, but they should not expose enough information to confidently choose weapons, armor, trade, or research.

Good Tier 1 clues:

- appearance: color, luster, texture, visible seam, unusual inclusions
- context: found in foothills, riverbed, ruin, crater, sacred grove, old dig
- social knowledge: local miners recognize it, do not recognize it, fear it, value it, or tell conflicting stories
- very rough handling impressions: chips oddly, leaves dust, rings strangely, stains tools, resists easy extraction

Risky Tier 1 clues that should often be delayed until testing or first handling discovery:

- clearly warm to the touch
- obviously fire-resistant
- obviously unusually heavy in a mechanically meaningful way
- obviously sharp, brittle, magically resonant, strength-enhancing, or armor-suited

The same descriptor should not map to the same property every run. A reddish glassy ore might be good for blades in one world, shield plating in another, trade value in another, and nearly useless militarily in another. A material described as heavy may simply be burdensome to ship, not automatically good armor. A faint ring when struck may be a harmless aesthetic trait, a clue to resonance, or a misleading surface behavior.

Design rule:

> Early clues should support educated guesses, not solved answers. Testing, research, and field use turn guesses into strategy.

#### Prototype Material Variant Rolls

For v0.1, the prototype should include a small set of possible hidden rolls for the first strange ore. These rolls are not meant to be the final material-generation system. They are test cases that prove the discovery loop: the same early clue can lead to different strategic conclusions in different worlds.

The placeholder name **Redglass Ore** can be reused across prototype runs, but it should not always mean the same thing. The player should be told explicitly that repeated Redglass runs are not guaranteed to share properties. In the final game, the name, appearance, and local story may all vary; for v0.1, reusing one recognizable placeholder is acceptable as long as the rules vary underneath.

All four example rolls can begin from the same restrained Tier 1 clue:

```text
Prospect: Unusual Red Seam
A thin red mineral line is visible in the exposed foothill stone. Local workers do not recognize it.
```

After survey, all four may produce the same basic confirmation:

```text
Deposit Confirmed: Redglass Ore
Surveyors confirm a workable deposit of unfamiliar red, glassy ore. Surface samples are stable enough to transport, but its practical uses are unknown.
```

The difference appears only after testing, research, or field use.

##### Variant A — Fire-Hardened Defensive Roll

Strategic lesson:

> This material is not obviously useful at first, but becomes valuable as defensive plating once its thermal behavior is discovered.

Possible Codex progression:

```text
Initial Codex:
- Source: Redglass Foothills
- Observed: Red, glassy mineral seam
- Known Uses: Unknown
- Risks: Unknown

After practical testing:
- Weapon Suitability: Low
- Armor / Shield Suitability: Medium
- Workability: Difficult
- Weight / Burden: High
- Value / Appeal: High

After academy or field discovery:
- Thermal Response: Strong fire resistance when used as shield or armor plating

Strategic Uses:
- Good for caravan guard shields
- Good for mine defense
- Good for settlement defense
- Poor first choice for offensive weapons
```

How it should play:

- Forging weapons quickly is possible, but inefficient.
- Forging armor or shields is better, especially if raiders use firepots or burning arrows.
- Waiting for research can reveal the defensive use before the first major commitment.
- Field use can reveal the same property if Redglass shields are exposed to fire in combat.

##### Variant B — Keen-Edge Offensive Roll

Strategic lesson:

> This material is valuable because it turns scarce ore into offensive initiative, but it may not help the player hold ground.

Possible Codex progression:

```text
Initial Codex:
- Source: Redglass Foothills
- Observed: Red, glassy mineral seam
- Known Uses: Unknown
- Risks: Unknown

After practical testing:
- Weapon Suitability: High
- Armor / Shield Suitability: Low
- Workability: Moderate
- Weight / Burden: Medium
- Value / Appeal: Medium

After academy or field discovery:
- Combat Property: Redglass weapons improve first-contact attack effectiveness

Strategic Uses:
- Good for proper watch squad weapons
- Good for attacking exposed raider parties
- Good for Blackbanner Camp assault preparation
- Poor first choice for caravan guard armor
```

How it should play:

- Forging weapons quickly can be a strong aggressive answer.
- A prepared watch squad with Redglass weapons can defeat raider parties more reliably.
- The player may choose to take pressure off the ore chain by attacking raiders before they gather.
- Armor-first players are not instantly doomed, but they receive less benefit from the material.

##### Variant C — High-Value / Low-Military Roll

Strategic lesson:

> Not every important discovery is a weapon. Some materials are strategically important because other people want them.

Possible Codex progression:

```text
Initial Codex:
- Source: Redglass Foothills
- Observed: Red, glassy mineral seam
- Known Uses: Unknown
- Risks: Unknown

After practical testing:
- Weapon Suitability: Low
- Armor / Shield Suitability: Low
- Workability: Low
- Weight / Burden: Medium
- Value / Appeal: Very High

After academy or field discovery:
- Material Note: The ore has unusual scholarly, ritual, decorative, or trade value, but limited immediate military use

Strategic Uses:
- Worth securing because others want samples
- Useful for future trade, diplomacy, specialist recruitment, or research
- Poor first choice for weapons or armor
- May still attract raiders, spies, scholars, or merchants
```

How it should play:

- The ore does not solve the immediate military problem by itself.
- The player may need to rely on basic watch squads, security, route management, and settlement defense.
- Raiders may still target the ore because it is valuable, even if it is militarily mediocre.
- This teaches that discovery is not always a direct combat upgrade.

For v0.1, full trade or diplomacy may not exist. This variant can still work if **Value / Appeal** increases raider interest, sample-theft risk, or scenario-score value. In a later build, this roll becomes much more important once trade, diplomacy, religious offerings, prestige equipment, or specialist markets exist.

##### Variant D — Volatile / Research-Favored Roll

Strategic lesson:

> Acting quickly can work, but this material rewards players who delay long enough to understand how to use it safely.

Possible Codex progression:

```text
Initial Codex:
- Source: Redglass Foothills
- Observed: Red, glassy mineral seam
- Known Uses: Unknown
- Risks: Unknown

After practical testing:
- Weapon Suitability: Uncertain
- Armor / Shield Suitability: Uncertain
- Workability: Very Difficult
- Weight / Burden: Medium
- Value / Appeal: High
- Warning: Rushed forging may produce flawed equipment

After academy analysis:
- Safe Use: Treated Redglass inlays or reinforced plating reduce failure risk

After field discovery, if rushed:
- Field Note: Rushed Redglass equipment performed strongly at first, then failed or caused losses under stress

Strategic Uses:
- Risky if rushed
- Better after research or careful forging
- Can become strong weapons or armor after the correct treatment is known
```

How it should play:

- The player may rush equipment and gain short-term power at real risk.
- Research gives a safer recipe or removes the flaw.
- The raider threat makes waiting costly, so the choice is not obvious.
- This variant best tests the quick-forge vs. research-delay tradeoff.

##### Variant Design Rules

The four prototype rolls should obey these rules:

1. **The first clue does not solve the material.** The same visual description can lead to different outcomes.
2. **Testing should reveal a usable direction, not full mastery.** Practical testing can suggest weapons, armor, value, or caution, but not every hidden property.
3. **Field use should still matter.** Some properties should be confirmed faster when the material is exposed to combat, fire, stress, or route pressure.
4. **Each roll should support a different strategic posture.** Defensive, offensive, economic/value-focused, and research-favored rolls all create different plans.
5. **No roll should be pure dead weight.** Even a low-military roll should create strategic value, pressure, or future promise.
6. **No roll should be auto-win.** A good material still requires labor, supplies, transport, forging, equipment coverage, and protection.

For the first playable prototype, not all four variants need to be implemented immediately. The most useful first pair is probably:

- **Fire-Hardened Defensive Roll**
- **Keen-Edge Offensive Roll**

Those two prove that the same discovery can push the player toward different military plans. The High-Value and Volatile variants can follow once the basic loop works.

### 13.4 Systems-Driven Material Model

Long-term, material identity should come from underlying systems rather than from hand-authored bonuses such as "+10% weapon damage."

Each material should be generated from a shared set of physical qualities. These qualities can be represented internally as sliders, ranges, or ratings. The player does not see the raw numbers at first; they see qualitative descriptions that point toward the hidden values.

Those descriptions should be deliberately non-deterministic. A surface clue can suggest a hypothesis, but it should not be a one-to-one translation key. The player should learn that observation is useful, but insufficient. The useful question is not "what bonus does this word mean?" but "what should I test before committing scarce labor and ore?"

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

For v0.1, resonance is optional. It can appear as a qualitative clue — for example, *"the ore gives a thin ring when struck"* — but that clue should not reliably mean magical resonance every time. The prototype should focus primarily on thermal response, weapon suitability, armor/shield suitability, weight/burden, workability, and value/appeal.

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


### 13.7 Prototype Material Codex Reveal Model

For v0.1, the Material Codex should prioritize clarity over mystery. The long-term game can use qualitative descriptions, approximate ranges, partial theories, and narrative field notes, but the prototype should make the discovery loop immediately legible.

Prototype rule:

> The Codex can state exactly what a revealed property is and what it modifies.

This is a deliberate prototype simplification. It is acceptable for v0.1 to reveal entries such as **Weapons: +2 attack**, **Armor: +2 defense**, **Fire damage taken: -50%**, or **Trade value: High** if that helps players understand why discovery matters. The long-term target remains a more systems-driven model where those outcomes emerge from underlying material behavior, equipment form, crafting process, and battle context.

The Codex should still reveal information progressively. A material does not need to expose every attribute at once. Each attribute can move from unknown to revealed as the player observes, tests, researches, or field-tests the material.

Recommended v0.1 reveal stages:

1. **Known appearance**  
   Revealed immediately when the material is encountered. This includes name, location, visible traits, and basic handling impressions.

   Example:
   - *Redglass Ore*
   - *Found in the Redglass Foothills.*
   - *Reddish, glassy seam found in the Redglass Foothills.*
   - *Local miners do not recognize the material.*
   - *Initial use unknown; testing required.*

2. **Physical testing results**  
   Revealed through a basic workshop, forge, or practical test.

   Example:
   - *Hardness: High*
   - *Brittleness: High*
   - *Workability: Low*
   - *Weapon suitability: Good for short blades; poor for long blades*
   - *Armor suitability: Risky unless reinforced or shaped carefully*

3. **Prototype explicit modifiers**  
   Revealed when the prototype needs to communicate a clear mechanical effect.

   Example:
   - *Redglass short weapons: +2 attack on first clash*
   - *Redglass armor plates: +1 defense*
   - *Redglass equipment: +50% carried weight cost*

4. **Magical or elemental results**  
   Revealed through academy analysis and/or field use.

   Example:
   - *Fire damage taken: -50% when used as shield or armor plating*
   - *Cold damage taken: +25% when used as armor plating*
   - *Wielder strength: +10% during combat when using Redglass weapons*

5. **Field confirmation**  
   Revealed when the material is used in a real scenario.

   Example:
   - *Field-confirmed: Redglass shields reduced casualties from raider firebombs.*
   - *Field-confirmed: Redglass blades performed well in the first clash but cracked during extended fighting.*

For the prototype, the Codex does not need to be coy. If a property is discovered, the player can be told what it does. The mystery comes from not knowing which properties a material has until discovery occurs, not from hiding the meaning of discovered properties behind overly vague prose.

Long-term, this can become more naturalistic. Instead of saying **+2 attack**, the game might eventually say a material holds a sharp edge, transmits shock poorly, resists flame, or carries high symbolic value. For v0.1, explicitness is acceptable because it proves the loop faster.

Design principle:

> In v0.1, the Codex should teach the discovery loop clearly. Once a property is discovered, the player should understand what decision it supports.

### 13.8 Prototype Material Attribute Set

For v0.1, material attributes should only exist if they feed a prototype decision, output, or discovery moment. The long-term game may support a richer physics model, but the first playable build should avoid attributes that imply systems the prototype does not actually implement.

Prototype rule:

> Do not add a material attribute unless the prototype has somewhere for that attribute to matter.

The v0.1 combat model is abstract, so attributes should map to a small set of visible outcomes: **weapon attack**, **armor/shield defense**, **fire interaction**, **shipment burden**, **forging/research difficulty**, and **trade/value**. More complex outcomes such as durability, morale, fear, fatigue, detailed injury, unit psychology, and long-term equipment maintenance should not be implied unless they are deliberately implemented.

#### Minimum v0.1 Attributes

| Attribute | What It Means | Prototype Use |
|----------|---------------|---------------|
| **Weapon Suitability** | How useful the material is for blades, spearheads, arrowheads, or other attacking forms | Reveals whether weapons made from the material improve squad attack |
| **Armor / Shield Suitability** | How useful the material is for armor, shields, plating, or reinforced protection | Reveals whether armor/shields made from the material improve squad defense |
| **Thermal Response** | How the material reacts to fire and heat | Reveals whether equipment reduces, worsens, or changes fire-based combat outcomes |
| **Weight / Burden** | How heavy the material is in practice | Affects shipment size/load and may affect equipment category only if movement penalties are implemented |
| **Workability** | How hard the material is to shape into reliable equipment | Affects forging time, whether rushed projects are risky, and whether research/specialists improve results |
| **Value / Appeal** | How desirable the material is beyond military usefulness, like gold | Supports trade value, barter value, sample theft value, or future non-military objectives |
| **One Simple Magical Modifier** | A direct magical effect on an implemented prototype stat | Only used if it maps to something the prototype already tracks, such as attack, defense, fire response, or movement |

This replaces the earlier overly broad attribute list for the prototype. Properties such as **hardness**, **toughness**, **brittleness**, **edge quality**, and **density** can still exist internally as world-generation ingredients, but the v0.1 player-facing Codex does not need to expose all of them as independent stats.

Instead, those ingredients can collapse into recipe-relevant outputs:

- **Weapon Suitability: High**
- **Weapon Suitability: Poor for long blades; good for short blades**
- **Armor / Shield Suitability: Medium**
- **Armor / Shield Suitability: High if reinforced**
- **Thermal Response: Fire damage reduced**
- **Workability: Difficult; rushed forging may produce flawed equipment**
- **Value / Appeal: High**

#### What Brittleness Means in v0.1

Brittleness should not imply a full durability or maintenance system in the prototype. If it is used at all, it should mean one of two simple things:

1. **Recipe suitability restriction**  
   The material is poor for certain forms. For example, brittle Redglass might be bad for long swords but acceptable for short blades, arrowheads, shield studs, or layered armor plates.

2. **Rushed-forging risk**  
   If the player forges quickly without testing, research, or a skilled smith, brittle material may produce flawed equipment. In abstract combat, this can appear as a one-time result such as *"Redglass blades cracked during the clash; attack bonus reduced."*

If neither of those prototype mechanics is implemented, brittleness should be hidden inside **Weapon Suitability**, **Armor / Shield Suitability**, and **Workability** rather than shown as its own Codex entry.

Design rule:

> In v0.1, brittleness is not durability. It is a clue about what forms the material can safely become and whether rushed forging is risky.

#### Prototype Codex Style

For the prototype, the Codex can be blunt. It does not need to be coy with natural-language ranges if direct clarity helps players understand the loop.

Example discovered entries:

| Category | Example Entry |
|---------|---------------|
| **Observed** | *Reddish, glassy seam; unfamiliar to local miners; no reliable use known yet.* |
| **Tested** | *Weapon Suitability: Good for short weapons; poor for long weapons.* |
| **Tested** | *Armor / Shield Suitability: Good as shield plating.* |
| **Tested** | *Workability: Difficult. Rushed forging may produce flawed equipment.* |
| **Magical / Elemental** | *Thermal Response: Reduces fire damage when used as shield or armor plating.* |
| **Value-Relevant** | *Value / Appeal: High. Raiders and scholars both want samples.* |
| **Field-Proven** | *Field-confirmed: Redglass shields reduced casualties from raider firebombs.* |

Long-term, the game can expose the underlying physical sliders more elegantly. For v0.1, the goal is to prove that discovery changes strategy.

Design principle:

> Prototype attributes should be scoped to implemented systems. Once a property is discovered, the player should understand which decision it supports.

### 13.9 First Strategic Equipment Decision

The first major player decision should be:

> Do I spend the first scarce batch of strange ore on weapons, armor, or research before committing it?

The player should initially have enough ore for one meaningful equipment order, not everything. This creates a concrete adaptation fork.

**Forge weapons now** gives immediate offensive power. It may help the player attack a raider camp, repel an early raid, or create a decisive first strike. The risk is that the material may later prove brittle, unstable, poorly suited to blades, or better used defensively.

**Forge armor now** gives immediate defensive power. It may protect caravan guards, mine workers, or settlement militia. The risk is that the material may later prove too heavy, reactive, vulnerable to blunt force, or better used offensively.

**Wait for testing or research** gives better information and may unlock a superior use case, but costs time while other actors move. Waiting should be valid but not automatically correct.

The design rule is:

> Quick forging gives immediate imperfect power and possible field discovery. Research gives safer knowledge and better crafting decisions, but sacrifices initiative.

### 13.10 Equipment Derivation Model

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

### 13.11 Prototype Pressure Model

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

### 13.12 Raider Pressure Logic

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


### 13.13 Raider Counterplay and Map-Entity Visibility Model

For v0.1, raider pressure should be represented primarily through **raider entities on the strategic map**, not through a visible attention meter or elaborate event-card clue chain.

Raiders exist in the world. They move, gather, watch, scout, and eventually attack. They may try to remain outside player vision, but they are not abstract pressure. If the player scouts the pass, patrols the road, builds a watchpost, or otherwise gains vision, raiders can be spotted before they strike.

The player-facing warning should be simple:

> You see raiders skulking near something valuable.

That sighting is the warning. The player does not need a large dramatic event every time. Eventually this kind of thing should happen across the map all the time: hostile scouts, suspicious patrols, opportunistic raiders, rival surveyors, religious agents, border watchers, and other actors moving through the living world.

For v0.1, the player has three clear forms of counterplay against raider pressure:

1. **Guard** — assign guards to the mine, escort caravans, or increase local route security.
2. **Scout** — send scouts to Ashen Pass, Old Pine Road, Redglass Foothills, or Blackbanner Camp to reveal raider movement before an attack.
3. **Reduce exposed activity** — limit stockpile buildup, move smaller shipments, pause extraction, or use a slower/less obvious route so there is less visible value for raiders to exploit.

True stealth and concealment should be a later system. The prototype does not need full stealth values, detection values, informants, bribed raiders, rumor networks, decoys, or misinformation. Those systems become more useful later, when hidden actors can leave partial evidence and the amount of detail revealed depends on relative stealth and detection.

For v0.1, the simplified model is:

- **Activity creates opportunity.** Mining, stockpiling, shipping, and forging rare ore make the area worth watching.
- **Raiders respond as actors.** Raider scouts or small parties move near Redglass Foothills, Ashen Pass, Old Pine Road, or the caravan route.
- **Vision reveals danger.** Scouts, patrols, watchposts, or passing caravans may reveal raider entities before they attack.
- **Sightings create notifications.** The UI can notify the player when a raider entity is spotted, when multiple raider parties gather, or when a known raider group begins moving toward the mine or caravan route.
- **Attacks reveal what was missed.** If the player does not scout or lacks vision, raiders may only become visible when they strike.

Notifications should usually be short sighting reports, not heavily scripted story events. Examples:

- **Raiders sighted near Ashen Pass.**
- **A small raider party is watching the mine road.**
- **Blackbanner raiders are gathering near the pass.**
- **Scouts report a raider group moving toward Redglass Foothills.**
- **A caravan crew spotted riders shadowing the route.**

The raiders should also be visible as map icons once spotted. A revealed raider entity may show approximate strength, last known direction, or target suspicion depending on available vision. A stronger scout presence gives clearer information. Weak or outdated sightings may become uncertain as raiders move back into fog of war.

The design should avoid presenting raider pressure as a named state such as "Quiet," "Noticed," "Watched," or "Targeted." Internally, the game may still track activity, suspicion, threat desire, or attack readiness, but the player should experience those systems through visible actors and sighting notifications.

Design principle:

> Raiders are physical actors, not a pressure meter. Seeing them skulking around the ore chain is the warning. Scouting does not fill a bar; it reveals what is already happening in the world.

### 13.14 Long-Term Pressure Direction

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


### 13.15 First Prototype Map

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
- **Activity evidence:** low, moderate, or high internal evidence level; surfaced through diegetic signs rather than a visible meter
- **Known threats / sightings:** none, rumor, tracks, spotted scout, shadowing party, raider group, or active attack
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

### 13.16 First Player Actions and Opening Flow

The first playable flow should teach the prototype loop through action rather than explanation. The player should quickly understand that the ore is strange, local, physical, valuable, and vulnerable. The opening should not require the player to understand the full future game. It only needs to prove this sequence:

> Discover → claim → extract → move → study or forge → adapt under pressure.

#### First Five Player Actions

The prototype should be designed around five early player actions. These are not necessarily the only buttons available, but they are the actions the opening must make clear and satisfying.

1. **Inspect the discovery**
   The player receives a discovery event for the strange ore in the Redglass Foothills. Clicking the event opens the region and the first Material Codex entry. The player sees Tier 1 qualitative observations, not stats.

   Example information:

   - reddish, glassy seam
   - unfamiliar to local miners
   - difficult to identify from appearance alone
   - unknown practical and magical behavior
   - testing, research, or field use required before reliable conclusions

   Design purpose: establish curiosity.

2. **Claim the deposit**
   The player commits Hearthmere labor to survey, mark, and claim the Redglass Foothills deposit. This creates the future extraction site and turns the discovery from an observation into a strategic commitment.

   Design purpose: make discovery actionable and create the first visible sign that may attract attention.

3. **Establish extraction posture**
   Before or as mining begins, the player chooses how the site is initially handled. The prototype can keep this simple with three choices:

   - **Rush extraction** — produce ore quickly, but create more activity and attention.
   - **Guard the mine** — reduce mine raid risk, but tie up militia or labor.
   - **Scout Ashen Pass** — reveal raider movement and route danger before committing a shipment.

   These do not need to be complex systems yet. The point is that the player must decide how much caution to apply before value starts accumulating.

   Design purpose: introduce pressure before the first caravan.

5. **Move the first ore shipment**
   Once a small amount of ore exists at the mine stockpile, the player creates or confirms the first route back to Hearthmere. The player chooses:

   - **Fast dangerous route:** Redglass Foothills → Ashen Pass → Hearthmere
   - **Slow quieter route:** Redglass Foothills → Old Pine Road → Westmere Farms → Hearthmere

   The player may also choose a simple shipment posture:

   - small shipment, lower attention, less immediate payoff
   - large shipment, higher attention, more immediate payoff
   - escorted shipment, safer route, fewer guards elsewhere

   Design purpose: prove that resources are physical and movement is strategic.

6. **Commit the first ore batch**
   When ore reaches Hearthmere, the player makes the central prototype decision:

   - **Forge weapons now** — immediate offensive posture with incomplete knowledge.
   - **Forge armor now** — immediate defensive posture with incomplete knowledge.
   - **Run practical testing / academy analysis first** — better knowledge and possible safer recipes, but lost time and continued raider attention.

   This decision should feel consequential even if the exact combat math is still abstract. The player should understand that they are choosing a strategy based on partial knowledge of a material that may behave differently in another world.

   Design purpose: connect discovery to adaptation.

#### First 10-Minute Prototype Flow

The exact timing can change during implementation, but the first test scenario should aim for this rough real-time experience. In-game time may represent several days; the real-time target is about 10 minutes of player experience.

**Minute 0–1: Scenario start and discovery**

The player begins at Hearthmere with the map paused or slowed. A scout/prospector event reveals the strange ore in the Redglass Foothills. The player clicks the event, sees the region, and receives the first Material Codex entry.

Desired player thought:

> What is this ore, and what can I do with it?

**Minute 1–2: Claim decision**

The player chooses to claim the deposit. Hearthmere sends workers/surveyors or commits labor. The Redglass Foothills changes from a discovered deposit to a developing extraction site. Local attention remains low but begins tracking.

Desired player thought:

> I need to secure this before someone else notices.

**Minute 2–4: Extraction posture**

The player chooses whether to rush extraction, guard the mine, or scout Ashen Pass. The choice affects early attention and risk. If the player does nothing, ore slowly accumulates at the mine and the site becomes more tempting.

Desired player thought:

> I can get ore faster, but activity leaves evidence.

**Minute 4–6: First shipment decision**

The first mine stockpile is ready. The player chooses a route and shipment posture. A fast shipment through Ashen Pass gets ore home sooner but risks being watched. A slow shipment through Old Pine Road buys caution at the cost of time. An escorted shipment is safer but pulls guards away from the mine or settlement.

Desired player thought:

> The ore is not mine until it actually reaches where I need it.

**Minute 6–8: Movement and sightings**

The caravan becomes visible on the map. If the player has scouted Ashen Pass, Old Pine Road, or the area around Redglass Foothills, they may spot raider entities before an attack: a small party watching the road, a group gathering near the pass, or riders moving toward the mine. If the player has not established vision, the raiders may remain unseen until they strike.

Desired player thought:

> The world is moving around my supply chain, and scouting tells me what is happening before it hits me.

**Minute 8–10: First commitment**

If ore reaches Hearthmere, the player chooses weapons, armor, or research/testing. If raider pressure interrupts the chain, the player resolves the first abstract conflict or response event before committing the ore. Either path should push the player toward the same central lesson: discovery is powerful, but acting on discovery exposes value.

Desired player thought:

> I have to make a strategy before I know everything.

#### Opening Flow Success Criteria

The first 10 minutes are successful if the player has:

- inspected multiple prospect opportunities or understood that not every lead is valuable
- inspected a mysterious material without seeing exact stats
- claimed a physical location on the map
- seen ore accumulate in a local stockpile
- created or chosen a physical shipment route
- understood that activity can attract visible world actors
- made at least one security/scouting/routing tradeoff
- committed scarce ore to weapons, armor, or research
- seen the Material Codex update at least once

The opening should avoid overexplaining future systems. The player does not need to understand Legacy Empires, coalitions, gods, alloy experimentation, or full tactical battles yet. The prototype succeeds if the player understands that knowledge, movement, and commitment are connected.

Design principle:

> The first 10 minutes should make the player curious first, cautious second, and strategic third.


### 13.17 Decision Surfaces and Action Model

AXIOM's interface should be built around **decision surfaces**: places, actors, routes, materials, and projects the player can inspect and act upon. The prototype should keep this simple, but the structure should already point toward the larger game.

The player should not primarily manage abstract menus. They should click things that exist in the world, inspect what is known about them, and choose context-appropriate actions.

Design principle:

> The player should make decisions through the world's physical objects: settlements, regions, routes, units, facilities, materials, and visible actors.

#### Prototype Decision Surfaces

For v0.1, the primary decision surfaces are:

1. **Player capital / main settlement**
   Hearthmere is the player's home base. It contains the local stockpile, labor pool, forge/workshop, academy/research function, militia, and starting strategic priorities.

   Prototype actions:
   - inspect settlement status
   - view local stockpile
   - assign broad labor priorities
   - start forge project
   - start research/testing project
   - assign militia to guard, escort, scout, or remain home

2. **Owned facilities**
   Facilities are controllable world objects attached to a region, such as the mine, forge, academy, watchpost, or future processing buildings.

   Prototype actions:
   - inspect facility status
   - start, pause, or prioritize production
   - assign labor
   - assign a specialist if available
   - assign guards if the facility is exposed

3. **Prospect opportunities / resource deposits**
   A prospect is a discovered but not-yet-controlled opportunity. Several prospects should exist in the prototype. Some are unfruitful, mundane, low-yield, or irrelevant to the immediate equipment fork. A valuable prospect becomes a claimed extraction site only after survey.

   Prototype actions:
   - inspect visible terrain or surface clues
   - send scout/prospector to survey
   - reveal outcome: valuable deposit, mundane material, poor yield, or false lead
   - inspect observed material traits if a material is found
   - claim deposit
   - establish extraction site
   - send sample to Hearthmere or academy once extraction begins
   - view local stockpile after mining starts

4. **Regions and unexplored areas**
   Regions are meaningful places on the strategic map. They may be controlled, friendly, neutral, hostile, unknown, or contested. Unexplored areas are also decision surfaces because the player can send scouts or decide whether a route is worth revealing.

   Prototype actions:
   - inspect known terrain, owner, safety, and visible entities
   - send scout or patrol
   - move a unit into the region
   - establish or inspect roads/routes if known

5. **Routes and roads**
   Routes are first-class decision surfaces because logistics are physical. A route is not just a line between places; it is a place where caravans, patrols, scouts, raiders, and danger can exist.

   Prototype actions:
   - inspect route length, estimated travel time, and known danger
   - create shipment route
   - choose fast or slow route
   - assign escort
   - pause or resume shipments
   - view caravans currently using the route

6. **Caravans and shipments**
   Caravans are visible moving entities carrying physical goods. They should be clickable while moving.

   Prototype actions:
   - inspect cargo, origin, destination, route, guard status, and estimated arrival
   - reroute if an alternate route exists
   - assign or remove escort before departure, or at safe nodes
   - pause future shipments on the same route

7. **Friendly units / squads / armies**
   Friendly military and scouting entities are controllable. In v0.1, these can be simple militia/scout/guard units rather than full armies.

   Prototype actions:
   - inspect strength, role, equipment, morale, wounds, and current assignment
   - move directly to a region or route
   - scout a region, route, or prospect area
   - guard a facility, settlement, route, or temporary guard post
   - escort a caravan by attaching to the shipment
   - intercept or attack visible hostile units if reachable
   - cancel assignment and return to direct orders

8. **Neutral or hostile units / squads / armies**
   Non-player units should be visible or hidden based on scouting and fog of war. The player generally cannot control them. The default interaction is inspection of known information.

   Prototype actions:
   - inspect visible or last-known information
   - track or scout if a friendly scout is available
   - intercept or attack with a friendly unit if possible
   - avoid, reroute, or guard against them

   For v0.1, raider parties only need basic visible states: spotted, last seen, moving, gathering, shadowing, attacking, or retreating.

9. **Friendly, neutral, and hostile settlements**
   Settlements are long-term decision surfaces. The prototype only requires Hearthmere, but the interaction model should anticipate later friendly, neutral, and hostile settlements.

   Prototype/future actions:
   - inspect known settlement status
   - trade, negotiate, threaten, request access, or raid in later versions
   - for v0.1, non-player settlements can remain inspect-only or flavor/background if present

10. **Material Codex and material entries**
    The Material Codex is not a physical location, but it is a core decision surface because it determines how the player interprets resources and equipment.

    Prototype actions:
    - inspect observed traits
    - inspect practical test results
    - inspect academy analysis progress
    - inspect field notes
    - choose next test/research use when enough sample/material is available

11. **Equipment projects**
    Weapons, armor, shields, and future equipment forms should be represented as projects rather than instant stat conversions.

    Prototype actions:
    - inspect recipe/material requirements
    - choose weapons, armor, or research delay
    - assign forge labor or specialist
    - view expected known behavior, uncertainty, and known risks
    - equip the resulting squad or guards

12. **Notifications and event log**
    Notifications should not replace map interaction. Their job is to point the player toward things happening in the world: a caravan departed, raiders were sighted, research completed, ore arrived, or a field discovery occurred.

    Prototype actions:
    - click notification to jump to relevant map object, codex entry, or project
    - inspect the underlying entity rather than resolve everything inside the notification itself

#### Prototype Interaction Rule

Every selectable object should share a simple structure:

- **Header:** name, type, owner/affiliation, and current state
- **Known information:** what the player knows right now
- **Uncertainty:** what is unknown or only suspected
- **Local contents:** units, stockpiles, facilities, routes, or projects connected to it
- **Context actions:** only the actions that make sense for this object and the player's relationship to it

Owned objects should offer direct control. Friendly objects should offer cooperation or support. Neutral objects should mostly offer inspection and future diplomacy. Hostile objects should mostly offer inspection, avoidance, scouting, interception, or attack.

#### v0.1 UI Scope

The prototype does not need every future action. It needs enough interaction to support the opening loop.

Minimum v0.1 panels:

- **Map selection panel** for regions, routes, units, caravans, and facilities
- **Settlement panel** for Hearthmere stockpile, labor, forge, academy, and militia
- **Material Codex panel** for Redglass observations, test results, analysis progress, and field notes
- **Route/shipment panel** for cargo, route, escort, destination, and ETA
- **Unit panel** for scouts, guards, militia, and spotted raider parties
- **Notification/event log** with clickable links back to map objects

Minimum v0.1 contextual actions:

- inspect
- claim deposit
- establish extraction
- assign labor priority
- start practical test / academy analysis
- forge weapons
- forge armor
- create shipment
- choose route
- assign escort
- send scout/patrol
- move squad directly
- assign squad to guard mine/settlement/route
- assign squad to escort caravan
- establish temporary guard post
- inspect raider party
- intercept/attack visible raiders if a friendly unit is available
- pause/resume time

#### Long-Term Expansion

Later versions can add deeper action sets to the same decision surfaces rather than replacing the interaction model. Examples include diplomacy with settlements, stealth and concealment actions, informants and rumors, bribery, decoy caravans, road construction, fortification networks, specialist drama, divine rituals, Legacy Empire negotiations, and full tactical battle entry points.

The prototype should therefore build the habit that every decision starts by asking:

> What object in the world am I acting on, what do I know about it, and what can I do from here?



### 13.18 Squad Command and Assignment Model

Friendly squads should support both direct command and assignment-based behavior. The player should be able to move a squad around the strategic map as a physical actor, but also attach that squad to a place, route, caravan, or job so it behaves appropriately without constant micromanagement.

Design principle:

> Squads are physical actors first, but assignments let them become part of a logistics or security system.

#### Direct Squad Control

Direct control means the player selects a friendly squad and gives it a destination or immediate task.

Prototype direct actions:

- move to a region
- move to a route or road node
- scout a region, route, or prospect site
- intercept a visible hostile unit
- attack a reachable raider party or camp
- retreat or return to Hearthmere

Direct control should be useful when the player wants to react to visible map information: raiders skulking near Ashen Pass, a prospect marker in unexplored foothills, a caravan route that looks exposed, or a mine that needs immediate defense.

#### Assignment-Based Squad Behavior

Assignments attach a squad to another world object or responsibility. The squad remains visible and physical, but its behavior is partially automated while the assignment remains active.

Prototype assignments:

1. **Guard settlement**
   The squad remains at Hearthmere and contributes to settlement defense.

2. **Guard mine or facility**
   The squad remains near the mine, forge, academy, or other facility and responds quickly if raiders approach or attack.

3. **Escort caravan**
   The squad attaches to a shipment and moves with it. If the caravan is attacked, the escort participates in the conflict. When the caravan arrives, the squad can return, wait, or require new orders.

4. **Scout region or route**
   The squad patrols a selected region/route and expands local knowledge over time. This reveals visible raider movement sooner and may discover prospect opportunities.

5. **Establish temporary guard post**
   The squad anchors itself in a chosen region or route, creating a light watch position. A guard post is not yet a full building. It expands vision, improves local response, and helps reveal raider movement in its area.

#### Assignment Tradeoffs

The same squad cannot be everywhere. Assigning a squad to escort a caravan means it is not guarding the mine. Assigning it to scout Ashen Pass means it may not be available to defend Hearthmere. The prototype should make this tradeoff obvious.

Desired player thought:

> I can move squads directly, but my logistics network gets safer when I assign them to jobs. Every assignment leaves something else uncovered.

For v0.1, squads do not need complex formations, individual soldiers, or full tactical loadouts. They need enough identity to make assignment choices meaningful: role, equipment, strength, wounds, morale, current location, and current assignment.


### 13.19 Prototype Prospecting Model

The prototype should include multiple prospect opportunities. The player should not simply be handed the correct mine. Finding a valuable site is part of exploration and part of the discovery fantasy.

Design principle:

> Discovery begins before extraction. The player must identify which opportunities are real before deciding what to claim and exploit.

#### Prospect Sites

Prospect sites are small map objects, not necessarily full regions. They may appear in Redglass Foothills, near Ashen Pass, along Old Pine Road, or in other partially known terrain. They represent visible signs that something may be present: unusual stone, exposed veins, strange soil, animal behavior, old dig marks, mineral color, heat shimmer, or local rumor.

For v0.1, use three prospect sites:

1. **Fruitful strange-ore site**
   This site reveals the main Redglass deposit after survey.

2. **Mundane or low-yield site**
   This site reveals ordinary material, insufficient volume, or something that is not immediately useful for weapons/armor.

3. **False or exhausted site**
   This site looks promising but does not justify extraction.

This small set lets the player experience prospecting without turning the prototype into a full geology simulator.

#### Prospecting Actions

Prototype actions:

- inspect visible clue
- send scout/prospector
- wait for survey result
- reveal prospect outcome
- claim valuable deposit
- ignore, mark, or return later to poor prospects

Prospecting should create a light opportunity cost. Sending a scout/prospector to one site means another site remains unknown. A squad assigned to prospecting is not simultaneously guarding the mine, escorting a caravan, or watching raiders.

#### Randomization

For the first tutorial-style prototype, the true Redglass site may be fixed to keep the flow understandable. In repeatable prototype runs, the true site can be randomized among several nearby prospect markers.

The goal is not to hide the game from the player. The goal is to teach that world knowledge is earned. A promising lead may fail. A strange material may be found somewhere unexpected. A player who scouts carefully has more options than a player who assumes the first visible lead is correct.

Desired player thought:

> I am not choosing from a menu of resources. I am exploring a physical world and figuring out what is actually useful.


### 13.20 Starting Situation and Opening Choice Model

The player should not begin the prototype blind, action-starved, or dependent on a single Civilization-style scout unit. AXIOM's opening should begin with basic knowledge of the surrounding region and several visible opportunities or concerns. The first decision is not "where do I move my only scout into darkness?" It is "given what my faction already knows about its immediate surroundings, what should I prioritize first?"

Design principle:

> The opening should be an assessment and prioritization problem, not a blank-map reveal problem.

#### Starting Knowledge

At the beginning of v0.1, the player should already know the broad shape of their local area. Hearthmere is not newly born into an unknown void. Its people know nearby roads, settlements, dangerous passes, old rumors, obvious prospect leads, and at least some local threats.

Known at start:

- Hearthmere's location, stockpile, labor, forge, academy, and militia capacity
- nearby regions and major routes
- several prospect opportunities, not yet confirmed as valuable
- at least one known danger area, such as Ashen Pass or Blackbanner Camp
- basic friendly/neutral/hostile presence in the immediate region
- obvious safe support areas, such as Westmere Farms

Unknown at start:

- which prospect site is truly valuable
- the generated properties of any strange material
- exact raider movement and readiness
- whether raiders are currently watching a route or target
- the best strategic use of the first discovered material

This preserves mystery without making the opening feel empty.

#### Opening Decision Menu

The first few minutes should offer several plausible priorities. For the prototype, farms and deeper economy can remain out of scope, but the structure should still imply that future AXIOM openings may include fertile land, trade opportunities, divine sites, neutral settlements, known threats, ruins, and military concerns.

Prototype opening priorities:

1. **Prioritize prospecting**
   Send scouts/prospectors to evaluate visible prospect sites quickly. This increases the chance of finding the valuable deposit early, but leaves security thinner.

2. **Prioritize security**
   Move or assign militia/guards toward Ashen Pass, Redglass Foothills, or a temporary guard post. This reduces surprise from raiders, but slows discovery and extraction.

3. **Prioritize preparation at Hearthmere**
   Assign labor toward forge readiness, research readiness, or militia organization before the deposit is confirmed. This can make the settlement better prepared once ore arrives, but risks preparing for the wrong opportunity.

4. **Prioritize route knowledge**
   Scout or patrol the fast dangerous route and the slower quiet route before committing shipments. This improves future logistics safety, but delays the first material payoff.

The player should have enough actions available immediately that the prototype begins with strategic triage rather than waiting for the first obvious button to unlock.

#### Prototype Starting Assets

For v0.1, the player does not need many units, but they should have more than one kind of agency. A clean starting set is:

- **Hearthmere Militia** — basic defensive squad; can guard settlement, guard mine, escort caravan, or attack/intercept visible raiders.
- **Survey Party** — light scout/prospector unit or assignment capacity; can inspect prospect sites, scout routes, and improve local visibility.
- **Labor Pool** — not a map unit, but a settlement resource assigned among prospecting support, extraction setup, forging, research, and security preparation.

If implementation needs to stay even simpler, the Survey Party can be represented as an assignment/action rather than a fully controllable squad. The important point is that the player should make an early prioritization choice between discovery, security, route knowledge, and preparation.

#### Future Opening Variety

Long-term AXIOM openings can vary dramatically depending on world generation and faction context. Some starts may show many prospect leads. Some may show fertile but undeveloped land. Some may begin near known bandit camps, hostile borders, strange ruins, divine sites, valuable trade routes, neutral settlements, or dangerous magical terrain.

The prototype only needs the prospect/security version of this structure, but it should be designed as the first example of a broader rule:

> The world presents several imperfect opportunities. The player chooses what to understand, secure, exploit, or ignore first.


### 13.21 Minimum v0.1 Interface and Action Set

The prototype interface should be simple, but it should already teach the player how AXIOM thinks: decisions are made through world objects, not through abstract global menus.

The player should be able to click a place, unit, route, material entry, or project and understand:

- what it is
- what is currently happening there
- what resources, squads, or risks are physically present
- what actions are available from that object
- what information is known, uncertain, or undiscovered

The UI should avoid a single global inventory or universal action menu. The player should feel that ore, people, caravans, workshops, and threats are located somewhere real.

Design principle:

> The interface should expose the world as a set of physical decision surfaces. The player acts by inspecting and commanding places, routes, squads, facilities, shipments, and materials.

#### Global Shell

The global shell exists only to keep the prototype readable. It should not become the main gameplay layer.

Minimum global elements:

- pause/play and speed controls
- current day/time
- alert list / event log
- Material Codex button
- selected object panel
- optional small summary of settlement labor, but not a global resource inventory

Alerts should usually be jump links back to physical world objects: a caravan, region, mine, squad, route, raider sighting, research project, or equipment project.

#### Strategic Map

The strategic map is the primary screen.

Clickable map objects for v0.1:

- regions
- Hearthmere settlement
- prospect sites
- Redglass deposit / mine
- roads and routes
- caravans / shipments
- player squads
- visible or last-seen raider units
- facilities inside settlement panels, not necessarily as separate map icons

The map should show raiders as physical entities when they are visible. If the player lacks vision, raiders may simply not be seen until they enter vision or attack.

#### Hearthmere Settlement Panel

Hearthmere is the player's initial command center.

Displayed information:

- settlement name and status
- local stockpiles stored at Hearthmere
- available labor pool
- labor priorities
- facilities: forge/workshop, academy/research space, militia yard or guard post
- owned squads currently present
- active projects and incoming/outgoing shipments

Minimum actions:

- inspect local stockpiles
- adjust labor priorities
- ready or manage militia/guards
- open forge/workshop actions
- open academy/research actions
- assign available squad to a mission or location
- receive incoming shipments

Hearthmere should not show ore that is still at the mine. Ore only appears in Hearthmere's stockpile after a caravan physically delivers it.

#### Region Panel

A region is a meaningful place on the map, not a tile.

Displayed information:

- region name
- controlling faction, if known
- terrain identity
- connected routes
- known sites or opportunities
- visible units, caravans, or raiders
- local vision / scouting state
- recent known sightings, if any

Minimum actions:

- inspect region
- send squad here
- scout region, if a squad or scouting assignment is available
- establish temporary guard post, if a squad is present and eligible
- inspect connected roads/routes

The region panel should not present a clean danger meter. It should show what is known: visible raiders, last-seen raiders, recent attacks, unscouted roads, and current friendly presence.

#### Prospect Site Panel

Prospect sites are visible opportunities whose value is uncertain.

Displayed information:

- site name or description
- visible surface clues
- survey status
- current certainty level in qualitative terms
- assigned survey party or squad, if any
- possible outcomes: unknown, barren, mundane material, low-yield deposit, valuable strange deposit

Minimum actions:

- inspect site
- begin survey
- assign survey priority or survey party
- cancel/redirect survey
- claim site if a useful deposit is confirmed
- ignore/deprioritize site

The player should begin with multiple prospect sites. Some should not lead to meaningful discoveries. Finding a good site is part of the opening discovery loop.

#### Deposit / Mine Panel

Once a useful deposit is confirmed and claimed, it becomes a physical extraction site.

Displayed information:

- deposit name
- known material description
- extraction status: unclaimed, claimed, mine establishing, active, paused, disrupted
- local mine stockpile
- assigned labor or extraction posture
- assigned guards
- connected shipment routes
- visible nearby friendly or hostile units

Minimum actions:

- claim deposit
- establish mine
- set extraction posture: quiet/cautious, normal, or rapid
- assign guards
- pause/resume extraction
- create shipment route
- send sample to Hearthmere/academy if a route exists

For v0.1, extraction posture can be simple. Quiet/cautious produces less quickly and generates less visible activity. Rapid produces more quickly but creates more visible activity and a larger exposed stockpile if logistics do not keep up.

#### Route / Road Panel

Routes are physical logistics spaces, not abstract lines.

Displayed information:

- connected regions
- travel time
- terrain type
- known friendly squads or caravans on the route
- visible or last-seen hostile presence
- active shipments using the route
- whether the route is currently scouted, guarded, or unknown

Minimum actions:

- inspect route
- create shipment using this route
- assign squad to scout route
- assign squad to guard or patrol route
- choose route for a shipment

For v0.1, the main route choice is between the faster Ashen Pass route and the slower Old Pine Road route.

#### Caravan / Shipment Panel

A caravan is a moving physical entity.

Displayed information:

- cargo type and amount
- origin and destination
- current location along route
- chosen route/path
- escort status
- estimated arrival
- current condition: moving, waiting, delayed, attacked, arrived, recalled

Minimum actions:

- inspect shipment
- assign escort if an eligible squad is available
- recall or cancel shipment, if still possible
- change route only when the caravan is at a node or safe decision point

A shipment should not be treated as a teleporting transaction. Until it arrives, the cargo remains physically exposed.

#### Squad Panel

Squads are the player's basic controllable military/scouting actors.

Displayed information:

- squad name/type
- location
- current order or assignment
- rough strength and role
- current equipment
- injuries/fatigue, if used in v0.1
- vision/scouting contribution

Minimum direct actions:

- move to region
- scout region or route
- attack visible hostile, if reachable
- return to Hearthmere

Minimum assignment actions:

- guard mine
- escort caravan
- patrol route
- establish temporary guard post
- defend Hearthmere

Squads should be physical actors first. Assignments are persistent jobs that make those physical actors behave as part of the logistics/security system.

#### Raider Unit Panel

Raiders are visible, hidden, or last-seen world entities depending on player vision.

Displayed information, when visible:

- approximate size or threat impression
- current location
- movement direction, if observed
- whether they appear to be scouting, gathering, traveling, attacking, or fleeing
- last-seen time if no longer visible

Minimum actions:

- inspect visible raider
- send squad to scout/track/intercept
- attack if an owned squad can reach or engage
- avoid by rerouting or delaying shipment

The prototype does not need a detailed hostile-intent UI. Raiders should communicate intent through movement and context: near the mine, watching a route, gathering near a pass, shadowing a caravan, or moving toward exposed stockpiles.

#### Forge / Equipment Project Panel

The forge turns delivered materials into military commitments.

Displayed information:

- available local materials at Hearthmere
- known material traits
- unknown or uncertain traits
- current equipment projects
- rough qualitative expectations, not exact bonuses
- required ore amount, labor, and time

Minimum actions:

- craft weapons from available ore
- craft armor/shields from available ore
- rush forge with incomplete knowledge
- wait for testing/research before committing
- equip completed gear to an owned squad

The forge panel should not say "Redglass Sword: +10% damage." It should use qualitative language derived from known properties, such as:

- "Smiths believe this ore may hold a sharp edge."
- "The material seems heavy for blades."
- "Shield plating appears promising, but heat behavior remains uncertain."

#### Academy / Research Panel

The academy or research space turns samples and time into knowledge.

Displayed information:

- samples available at Hearthmere
- active analysis project
- known Tier 1 observations
- tested Tier 2 physical findings
- vague Tier 3/magical findings, if any
- field-use progress represented qualitatively through notes, not a visible numeric threshold

Minimum actions:

- analyze sample
- run basic material test, if combined with academy for v0.1
- pause or switch research focus
- open related Material Codex entry

For v0.1, practical testing and formal analysis can be represented through a small number of research actions rather than separate fully simulated buildings.

#### Material Codex Panel

The Material Codex is the player's accumulated understanding of this world.

Displayed information:

- material name or provisional name
- Tier 1 observed description
- Tier 2 physical findings
- Tier 3/magical findings if discovered
- field notes
- known uses and warnings
- unresolved questions

Minimum actions:

- inspect material entry
- jump to relevant deposit, mine, forge project, or research project
- mark material as priority for research, if needed

The codex should reveal knowledge in qualitative language. It should not expose raw hidden sliders unless a later design pass intentionally includes advanced expert views.

#### Notifications / Event Log

Notifications should support awareness without replacing the map.

Prototype notification categories:

- survey complete
- deposit confirmed or site barren
- mine established
- shipment departed/arrived/delayed/attacked
- raider sighted
- research/test complete
- field discovery occurred
- equipment project complete

Each notification should link to the relevant object. The notification is a summary; the map object is the source of truth.

#### Minimum Opening Action Set

The opening action set must give the player enough to do immediately without overwhelming the prototype.

The first playable scenario should support these actions:

1. inspect Hearthmere and nearby known regions
2. inspect multiple prospect sites
3. assign a survey/prospecting action to one site
4. inspect known danger near Ashen Pass or Blackbanner Camp
5. direct or assign a squad to scout, guard, or prepare
6. confirm a useful ore deposit
7. claim the deposit
8. establish extraction
9. choose extraction posture
10. create a shipment route
11. choose fast/dangerous or slow/safer path
12. assign escort or route scout
13. deliver ore to Hearthmere
14. commit ore to weapons, armor, or research/testing
15. equip completed gear or update the Material Codex
16. respond to visible raider movement or attack

This is the minimum action language of the prototype. More complex diplomacy, stealth, decoys, informants, advanced farming, trade, and settlement development can be added later.

### 13.22 Prototype Simulation Tick and Time Model

AXIOM's strategic map is real-time with pause and speed controls, but the prototype needs a clear simulation rhythm so logistics, research, forging, scouting, raider movement, and supply consumption all advance predictably.

For v0.1, the simulation should use an **hourly tick**. The UI may summarize many projects in days, but the underlying world should update in hours. This gives enough granularity for travel time, caravan interception, mine operations, scouting, supply consumption, and eventual day/night behavior without requiring a complex continuous simulation.

Prototype rule:

> One simulation tick equals one in-game hour. Most strategic projects can be summarized in days, but movement, supply, scouting, visibility, and threat response should be able to resolve at the hourly level.

#### Why Hours Instead of Days

An hourly tick supports several important AXIOM goals:

- caravans can be intercepted before or after reaching a node,
- scouts can reveal raiders before an attack occurs,
- raiders can shadow, gather, strike, or withdraw over visible travel time,
- remote squads can run low on carried supplies during an assignment,
- mining and guard posts can consume supplies while active,
- research and forging can still feel like multi-day projects,
- and future day/night mechanics have a natural foundation.

A daily tick would be easier to implement, but it would make the living map feel too chunky. A caravan that leaves in the morning, is shadowed by raiders in the afternoon, and is ambushed at dusk is exactly the kind of physical-world pressure the prototype should begin to support.

#### Day and Night Foundation

Day/night mechanics do not need to be deep in v0.1, but the time model should make them possible. At minimum, the game should track whether the current hour is daytime or nighttime.

Initial prototype use cases:

- **Visibility:** scouting and sight range may be weaker at night.
- **Raider behavior:** raiders may prefer to move, gather, or attack near dusk/night.
- **Caravan timing:** a player may choose whether to send a shipment now or wait for daylight.
- **Crisis framing:** a night raid should feel different from a daylight interception, even if the abstract combat math is simple.

For the first implementation, day/night can mostly modify visibility and event flavor. More detailed night movement, stealth, fatigue, camp security, ambush bonuses, and ritual/magical timing can wait.

#### Hourly Update Order

Each in-game hour should resolve in a predictable order. A simple order is:

1. **Production and scheduled generation**
   Settlements generate supplies or other time-based outputs when their production interval is reached. This may happen daily rather than every hour, but it is checked through the hourly system.

2. **Consumption**
   Active mines, remote squads, guard posts, and other sustained commitments consume supplies. If supplies are missing, they become slowed, strained, paused, or vulnerable depending on the object.

3. **Movement**
   Squads, caravans, raiders, scouts, and other map entities advance along their routes based on speed, terrain, assignment, cargo burden, and time of day if relevant.

4. **Visibility and detection**
   Scouts, guard posts, settlements, and squads reveal nearby visible entities. Raiders are not surfaced through a pressure meter; they are seen, last-seen, or hidden based on map vision and detection.

5. **Project progress**
   Surveying, mining setup, research, forging, construction, and recovery projects advance if they have required labor, supplies, materials, and facility access.

6. **Actor decisions**
   Raiders and future AI actors decide whether to keep watching, move, gather, raid, ambush, retreat, or ignore an opportunity. For v0.1, raider decision logic can be simple and local.

7. **Conflict checks and resolution**
   Ambushes, mine raids, skirmishes, settlement attacks, camp assaults, and interception attempts resolve if opposing entities or objectives meet the required conditions.

8. **Discovery progress and Codex updates**
   Research, testing, and field use add discovery progress. If a threshold is reached, the Material Codex updates and the player receives a notification.

9. **Notifications and crisis slowdown**
   The player receives alerts for meaningful changes: sightings, arrivals, shortages, completed projects, attacks, discoveries, and route disruptions.

#### Daily Summary Layer

Although the simulation ticks hourly, the UI should not force the player to think in hourly micromanagement for every system. Some information should be summarized as days or remaining time:

- analysis complete in 2 days,
- forge project complete in 18 hours,
- mine has supplies for 3 days,
- caravan arrives in 7 hours,
- squad carried supplies last 14 hours,
- Hearthmere produces supplies each morning.

This keeps the world granular without making the interface exhausting.

#### Crisis Slowdown

The real-time controls should include crisis slowdown. When an important event occurs, the game should automatically slow to the lowest speed or pause depending on player settings.

Events that should trigger slowdown or pause:

- caravan ambushed,
- mine raided,
- Hearthmere threatened,
- squad enters combat,
- visible raiders approach a protected object,
- supply route fails or a remote site runs out of supplies,
- research completes,
- forging completes,
- material property discovered,
- prospect survey discovers a major deposit.

The design goal is to preserve the living real-time map without punishing the player for not watching every road every second.

#### Implementation Guidance

The prototype does not need perfect continuous simulation. It only needs consistent hourly progression for the systems that create meaningful decisions. The player should feel that time is passing, the world is moving, and delays matter.

If a mechanic does not yet need hourly granularity, it can still update on daily or project intervals while being scheduled through the hourly tick.

Design principle:

> Time should make the world feel alive without forcing frantic micro. Hours create enough granularity for movement, visibility, supply, and day/night pressure; pause and crisis slowdown keep the game strategic rather than twitchy.


#### Initial Prototype Timing Targets

The first timing values should be treated as tuning placeholders, not final balance. The purpose of these numbers is to give the prototype a playable rhythm anchored around movement, response time, and the feeling that distant commitments take real time to support.

Core pacing principle:

> Movement and response time should anchor the rest of the prototype. Projects, research, forging, and raider behavior should be balanced around how long it takes squads, caravans, and raiders to move through the world.

##### Movement Targets

Adjacent-region travel should usually take hours, not minutes or days. The player should be able to react to nearby problems, but not instantly.

Suggested starting values:

| Entity / Situation | Road Travel Between Adjacent Regions | Rough / Dangerous Travel |
|---|---:|---:|
| Scout or light raider party | 3–5 hours | 5–8 hours |
| Unburdened militia squad | 5–7 hours | 8–12 hours |
| Militia escorting caravan | 7–10 hours | 12–16 hours |
| Loaded caravan | 8–12 hours | 14–20 hours |
| Fleeing remnants / raiders abandoning cargo | 3–5 hours | 5–8 hours |

For the first prototype map, the fast route from Redglass Foothills through Ashen Pass to Hearthmere should feel meaningfully faster but riskier than the safer Old Pine Road route.

Suggested route targets:

- **Fast dangerous route:** Redglass Foothills → Ashen Pass → Hearthmere should take roughly 10–16 hours for a loaded caravan.
- **Slow quieter route:** Redglass Foothills → Old Pine Road → Westmere Farms → Hearthmere should take roughly 20–30 hours for a loaded caravan.

The exact values can be adjusted after testing, but the player should immediately understand that route choice affects both arrival time and exposure.

##### Prospecting and Claiming Targets

Prospecting should be quick enough that the opening does not feel empty, but slow enough that prioritizing survey work is a real decision.

Suggested starting values:

| Action | Initial Target |
|---|---:|
| Inspect known prospect lead | Immediate |
| Survey obvious false/poor lead | 8–12 hours |
| Survey normal lead | 12–24 hours |
| Confirm valuable deposit | 24–36 hours total survey effort |
| Claim deposit after confirmation | 6–12 hours |
| Establish basic extraction camp | 24–36 hours |

The player should usually identify at least one meaningful lead early, but should not be able to fully confirm every prospect before the world begins reacting.

##### Mine, Supply, and Shipment Targets

The mine should become productive quickly enough to feed the prototype loop, but not so quickly that logistics are skipped.

Suggested starting values:

| Action / System | Initial Target |
|---|---:|
| Mine begins consuming supplies | Immediately once active |
| First ore batch after mine activation | 12–24 hours |
| Subsequent ore batch | Every 12–24 hours while supplied |
| Supply delivery loading/unloading | 1–2 hours |
| Mine supply buffer target | 2–3 days when stocked |
| Remote squad carried supply buffer | 12–24 hours |
| Guard post supply buffer | 1–2 days |

The mine should consume supplies even when nothing dramatic is happening. If the player leaves the mine active but does not maintain supply delivery, extraction should slow, pause, or become vulnerable.

##### Research and Forge Targets

Research and forging are balance levers. They should create real time pressure without forcing the player to sit idle.

Suggested starting values:

| Project | Initial Target |
|---|---:|
| Basic practical test | 12–24 hours |
| Initial academy analysis | 24–48 hours |
| Deeper magical/weird property progress | 48–72 hours or multiple progress sources |
| Rushed weapon or armor order | 24 hours |
| Careful weapon or armor order | 36–48 hours |
| Academy-informed improved order | 48 hours, after relevant discovery |
| Equip completed gear onto squad at Hearthmere | Immediate or 1–2 hours |

The player should be able to rush a first military application before full research completes, but waiting for research should provide enough benefit or certainty to feel tempting.

##### Raider Timing Targets

Raider behavior should not feel like a generic scaling timer. Timing should represent visible actor movement and opportunity response.

Suggested starting values:

| Raider Behavior | Initial Target |
|---|---:|
| First raider scouts appear after valuable activity begins | 12–24 hours |
| Raiders gather into a meaningful threat | 24–48 hours after repeated/exposed activity |
| Caravan shadowing before possible ambush | 3–8 hours of visible proximity if detected |
| Mine raid preparation after large exposed stockpile | 12–24 hours |
| Camp assault window before raiders recover/reorganize | 24–48 hours after a major raider loss |

These should remain conditional. Raiders should respond to exposed value: moving caravans, unguarded stockpiles, repeated shipments, visible military preparation, and weakly defended routes.

##### Scenario Pacing Target

The first prototype scenario should ideally cover roughly 7–14 in-game days, depending on player speed and decisions.

A rough intended arc:

1. **Day 1:** inspect starting situation and begin surveying prospect leads.
2. **Day 1–2:** confirm a valuable ore deposit or eliminate false leads.
3. **Day 2–3:** claim the deposit and establish basic extraction.
4. **Day 3–5:** move first ore, choose research/weapons/armor, and observe raider movement.
5. **Day 5–8:** first major caravan ambush, mine raid, or defensive crisis.
6. **Day 7–14:** secure the ore chain, complete a key discovery, or assault/clear Blackbanner Camp.

These pacing targets are only starting points. Testing should focus on whether the player feels pressured to make tradeoffs, not whether the exact day count is preserved.

##### Tuning Guidance

If the prototype feels too slow:

- reduce survey and setup times,
- increase caravan speed,
- shorten first forge/research projects,
- or make the first raider contact happen later.

If the prototype feels too safe or obvious:

- increase caravan travel time,
- make the slow route safer but significantly slower,
- make the mine consume supplies faster,
- make raiders appear earlier after repeated exposed activity,
- or reduce how much the player can accomplish with Hearthmere's starting capacity.

If the prototype feels too frantic:

- increase warning through visible raider movement,
- delay the first serious raid,
- increase Hearthmere's starting supply stockpile,
- or reduce the number of simultaneous active threats.

Design principle:

> Timing should create commitment and consequence. The player should have time to respond, but not enough time to do everything perfectly.

### 13.23 Prototype Combat Resolution Model

The long-term vision includes squad-scale tactical battles, but v0.1 should use a simple abstract combat resolver unless a tactical test is cheap to implement. The prototype combat system only needs to prove three things:

1. weapons and armor choices matter,
2. raider pressure can threaten mines, caravans, and Hearthmere,
3. field use can reveal material properties.

Prototype rule:

> v0.1 combat is an abstract result screen attached to physical map conflicts. Tactical battles are a future layer.

#### Combat Triggers

Combat or conflict resolution can occur when:

- raiders intercept a caravan,
- raiders raid the mine stockpile,
- raiders attack Hearthmere,
- a player squad attacks a visible raider party,
- a player squad attacks Blackbanner Camp,
- a guard post or patrol responds to a nearby raider movement.

Each conflict should have a clear objective, not just a generic fight.

| Conflict Type | Main Question |
|--------------|---------------|
| **Caravan Ambush** | Does the cargo get through, get delayed, or get stolen? |
| **Mine Raid** | Is the local stockpile protected, partially stolen, or lost? |
| **Settlement Attack** | Does Hearthmere hold, suffer damage, or get sacked? |
| **Raider Skirmish** | Are raiders driven off, weakened, or emboldened? |
| **Camp Assault** | Is Blackbanner Camp cleared, damaged, or left intact? |

#### Minimum Combat Stats

For v0.1, squads and raider groups only need a few simple values:

| Value | Meaning |
|------|---------|
| **Attack** | Ability to harm, drive off, or defeat the enemy |
| **Defense** | Ability to hold position, protect cargo, and avoid losses |
| **Speed** | Ability to move on the strategic map, intercept, avoid, pursue, or withdraw |
| **Strength / Condition** | A simple readiness state, such as Ready, Wounded/Recovering, or Killed/Destroyed |
| **Role / Assignment** | Escorting, guarding, scouting, patrolling, attacking, or idle |
| **Equipment** | Current weapons, armor/shields, and any known material-derived modifiers |
| **Supply Status** | Whether the squad has enough supplies to continue operating effectively |

Avoid adding detailed morale, fatigue, durability, fear, ammunition, formation, or injury systems unless they are intentionally implemented. They can appear later when tactical battles exist.

#### Abstract Resolution

Each conflict compares a friendly score against a raider score. The exact formula can be simple during prototyping:

```text
Friendly Score = Squad Attack or Defense
               + Equipment Modifier
               + Assignment / Position Modifier
               + Relevant Material Modifier
               + Random Variance

Raider Score = Raider Strength
             + Ambush / Camp / Objective Modifier
             + Random Variance
```

The relevant friendly stat depends on the objective:

- caravan escort and mine defense primarily use **Defense**,
- attacking raider parties or Blackbanner Camp primarily uses **Attack**,
- settlement defense uses **Defense**, with Hearthmere fortification or militia support if implemented.

Possible results:

| Result | Meaning |
|-------|---------|
| **Clean Success** | Objective achieved with little loss |
| **Costly Success** | Objective achieved, but squad is wounded, delayed, or cargo is partially lost |
| **Partial Failure** | Some cargo/stockpile is lost, but the squad survives and the game continues |
| **Major Failure** | Squad routed, cargo lost, mine damaged, or raiders grow bolder |
| **Scenario Defeat** | Hearthmere is sacked and the prototype ends |


#### Prototype Combat Context Resolvers

The abstract combat resolver should not treat every conflict as the same fight. Each conflict type has a different objective, different stakes, and different stats that matter most.

Prototype rule:

> Combat is objective-based. The question is not only "who wins the fight?" but "what happened to the cargo, mine, settlement, camp, or route?"

For v0.1, use four primary context resolvers.

##### 1. Caravan Ambush Resolver

The caravan ambush is the most important v0.1 conflict because it ties together discovery, logistics, raider pressure, squads, speed, equipment, and field discovery.

Main question:

> Does the shipment reach its destination, get delayed, get partially stolen, or get lost?

Inputs:

| Input | Use |
|------|-----|
| **Caravan Cargo Value** | Determines how attractive the target is and how severe loss feels |
| **Caravan Speed** | Affects whether the caravan can escape, delay contact, or reach safety |
| **Escort Defense** | Main friendly combat value if a squad is assigned to protect the shipment |
| **Escort Attack** | Matters if the escort counterattacks or pursues raiders |
| **Raider Attack** | Main raider value for overwhelming guards and taking cargo |
| **Raider Speed** | Affects interception, escape, pursuit, and stolen cargo recovery |
| **Route Context** | Fast/dangerous Ashen Pass versus slower/quieter Old Pine Road |
| **Supply Status** | Undersupplied escorts perform worse; supply cargo may itself be lost |
| **Relevant Equipment Properties** | Armor/shields help protect guards and cargo; weapons help drive raiders off |
| **Relevant Field Conditions** | Firebombs, bad weather, terrain, night attack, or other simple context tags if implemented |

Suggested outcome bands:

| Outcome | Result |
|--------|--------|
| **Clean Delivery** | Caravan arrives; raiders driven off or fail to engage |
| **Delayed Delivery** | Caravan survives but arrives late; route may remain dangerous |
| **Costly Delivery** | Cargo arrives, but escort becomes Wounded/Recovering or loses manpower |
| **Partial Theft** | Some cargo is stolen; surviving caravan continues or returns |
| **Total Loss** | Cargo lost; caravan destroyed or forced to abandon shipment |
| **Counter-Raid Success** | Escort wins decisively and weakens the local raider presence |

Caravan ambushes should be predictable enough that preparation matters. A slow unescorted high-value ore shipment through Ashen Pass should feel obviously risky. A guarded shipment on a scouted route should feel safer, but not mathematically guaranteed.

Speed-specific rules:

- A slow caravan cannot usually escape once a fast raider party commits.
- A fast escort or nearby patrol may intercept raiders before the caravan is overwhelmed.
- A faster raider party may steal cargo and withdraw even if it cannot defeat the escort outright.
- A faster victorious escort may recover stolen cargo or prevent raiders from regrouping.

Field discovery hooks:

- Redglass shields can reveal defensive or thermal properties if raiders use firebombs or burning arrows.
- Redglass weapons can reveal weapon suitability if the escort counterattacks.
- Heavy or awkward equipment can reveal speed/burden issues if the caravan fails to evade or respond quickly.

Design note:

> The caravan ambush resolver should make the player think about what they shipped, how they shipped it, who guarded it, which road they used, and whether they understood the material well enough before committing it to the field.

##### 2. Mine Raid Resolver

The mine raid tests local stockpiles, guard assignments, and the cost of leaving value sitting in a remote location.

Main question:

> Do raiders steal ore/supplies, damage the mine, or get repelled?

Inputs:

| Input | Use |
|------|-----|
| **Mine Stockpile Value** | Higher value makes the raid more consequential |
| **Mine Guard Defense** | Main friendly value if a squad is assigned to guard the site |
| **Mine Guard Supply Status** | Guards away from Hearthmere need supplies to remain effective |
| **Raider Attack** | Main raid pressure value |
| **Raider Speed** | Determines whether raiders can strike and escape before response arrives |
| **Nearby Patrol / Guard Post** | May join or modify the defense if close enough |
| **Mine Preparedness** | Simple modifier for claimed/active/fortified site if implemented |

Suggested outcome bands:

| Outcome | Result |
|--------|--------|
| **Raid Repelled** | Stockpile protected; raiders weakened or withdraw |
| **Minor Theft** | Some ore/supplies stolen; mine continues operating |
| **Major Theft** | Significant stockpile loss; extraction plan disrupted |
| **Mine Damaged** | Extraction pauses until repaired/resupplied |
| **Guard Loss** | Guard squad becomes Wounded/Recovering or destroyed |

The mine raid should punish unattended buildup, not ordinary player experimentation. The player should be able to see that stockpiling valuable ore at an under-guarded remote site creates an opportunity for raiders.

##### 3. Settlement Defense Resolver

Settlement defense is the prototype's primary defeat check. It should be rare compared to caravan ambushes and mine raids, but serious when it happens.

Main question:

> Does Hearthmere hold, suffer damage, or get sacked?

Inputs:

| Input | Use |
|------|-----|
| **Hearthmere Defense** | Base settlement defensive value |
| **Available Militia / Squads** | Adds defense if present and supplied |
| **Armor / Shields** | Improve defensive performance |
| **Raider Attack Strength** | Determines severity of the assault |
| **Raider Losses Before Attack** | Prior skirmishes/camp damage can weaken the assault |
| **Supply Stockpile** | Settlement supply shortages may reduce ability to withstand attack |

Suggested outcome bands:

| Outcome | Result |
|--------|--------|
| **Hold Firm** | Attack repelled; raiders weakened |
| **Damaged Hold** | Hearthmere survives but loses supplies, coin, equipment, or facility time |
| **Emergency Defense** | Settlement barely survives; militia becomes Wounded/Recovering |
| **Sack / Pillage** | Prototype defeat condition; Hearthmere falls or is devastated |

Settlement defense should not be the normal first punishment. It is the consequence of repeated failure, serious overextension, or choosing to leave Hearthmere exposed while the raider threat grows.

##### 4. Raider Camp Assault Resolver

Camp assault is the prototype's main military victory path.

Main question:

> Can the player clear or disperse Blackbanner Camp?

Inputs:

| Input | Use |
|------|-----|
| **Player Attack** | Main friendly value for assaulting the camp |
| **Player Defense / Armor** | Reduces losses during the assault |
| **Player Supply Status** | Attacking away from Hearthmere requires carried or delivered supplies |
| **Player Speed** | Affects whether raiders can withdraw, scatter, or be pursued |
| **Raider Camp Strength** | Base camp defense and number of raiders present |
| **Previous Raider Losses** | Prior patrol wins, failed raids, or counter-raids reduce camp strength |
| **Route Knowledge / Scouting** | May provide a simple advantage if the camp has been scouted |

Suggested outcome bands:

| Outcome | Result |
|--------|--------|
| **Camp Cleared** | Primary military victory; raider threat removed or dispersed |
| **Camp Damaged** | Raider strength reduced; follow-up assault easier |
| **Costly Victory** | Camp cleared, but player squad is Wounded/Recovering or loses manpower |
| **Failed Assault** | Player retreats; raiders remain and may counterattack |
| **Disaster** | Player squad destroyed or Hearthmere left exposed to follow-up attack |

The camp assault should be understandable but not automatic. Forging Redglass weapons may make this path more appealing. Forging Redglass armor may make earlier caravan and mine defense safer, which indirectly weakens the camp by denying successful raids.

#### Formulaic Combat and Prototype Acceptance

The v0.1 resolver will likely be somewhat formulaic. That is acceptable if it creates clear decisions around preparation, equipment, supplies, route choice, and timing.

The prototype should avoid hiding everything behind randomness. The player should usually understand whether a fight is favorable, risky, or desperate. Uncertainty should come from incomplete scouting, imperfect material knowledge, context modifiers, and modest variance — not from opaque dice rolls.

Prototype target:

> Combat should be simple enough that the player understands why they won or lost, but connected enough to the rest of the game that the result reflects prior discovery, logistics, equipment, supply, speed, and scouting decisions.

#### Speed, Withdrawal, and Pursuit

Speed should matter even in abstract combat because the game is built around physical map entities. A squad's speed affects more than travel time; it influences whether a conflict happens, whether a losing force can escape, and whether a winning force can pursue.

Prototype rule:

> Speed is a strategic-map stat first and a combat-context modifier second.

Minimum speed uses in v0.1:

- **Map movement:** faster squads traverse routes more quickly.
- **Interception:** faster raiders can catch slow caravans more easily; faster patrols can respond to sightings sooner.
- **Withdrawal:** a squad or raider party that is losing may escape if it is faster than its opponent or has a clear route out.
- **Pursuit:** a faster victor may inflict greater losses, recover stolen cargo, or prevent raiders from regrouping.
- **Caravan vulnerability:** caravans are slow and cargo-burdened, so they should rarely escape a committed ambush without escorts, a safer route, or advance warning.
- **Remnant escape:** a badly beaten military unit may still escape if it abandons cargo, disperses, or withdraws through favorable terrain.

For v0.1, speed does not need a deep encumbrance or fatigue model. It can be a simple value modified by entity type, route terrain, assignment, supply status, and heavy equipment if implemented.

Example prototype interpretation:

```text
Caravan: Slow; poor escape chance if ambushed.
Militia Squad: Normal; can withdraw from some losing fights.
Light Raider Party: Fast; good at ambush, scouting, and escape.
Burdened Escort: Slower if heavily armored or tied to a caravan.
```

Speed should not make combat overly fiddly. It exists to make the map feel physical: some forces can catch, flee, delay, shadow, or escape others.

#### How Weapons and Armor Matter

Weapons and armor should map to simple attack/defense changes.

- **Weapons** improve squad Attack and make camp assaults or counterattacks more viable.
- **Armor/shields** improve squad Defense and make caravan escort, mine defense, and settlement defense more reliable.
- **Thermal Response** matters only if the conflict includes firebombs, burning terrain, fire magic, forge accidents, or another implemented fire exposure.
- **Workability / rushed forging risk** can produce flawed equipment if the player acts before testing or research.

For the prototype, it is acceptable for the Codex to say direct things like:

- *Redglass short weapons: +2 Attack.*
- *Redglass shields: +2 Defense.*
- *Redglass plating: Fire damage reduced during firebomb attacks.*
- *Rushed Redglass long blades: risk of flawed equipment.*

These explicit modifiers are prototype scaffolding. The long-term game should derive these outcomes from deeper material behavior, equipment form, crafting process, unit role, and tactical context.

#### Future Tactical Exploitation of Material Properties

The prototype's abstract combat resolver will probably feel formulaic. That is acceptable for v0.1 because its job is to prove the strategic loop, not the final battle system.

Long-term, combat should let the player actively exploit discovered material behavior in more expressive ways. For example, if a faction discovers that its armor has strong fire resistance, it should eventually be able to build a strategy around that knowledge: equip troops with fire-resistant gear, deploy fire mages or incendiary tactics aggressively, fight in burning terrain, or use fire in ways that would be suicidal for ordinary armies.

This is one of the clearest examples of AXIOM's core fantasy:

> Discover a strange property, understand its implications, then reshape strategy around it.

v0.1 does not need to support that full tactical expression. It only needs to make the first step visible: fire-resistant gear matters when fire exposure appears in an abstract conflict. The richer version belongs later, when tactical battles, spell use, battlefield terrain, unit roles, and deliberate combined-arms tactics exist.

#### Field Discovery During Combat

Combat should be one of the main ways the player learns. When equipment made from an incompletely understood material is used in a relevant conflict, the resolver can add discovery progress and create a Codex note.

Examples:

- Redglass weapons crack during a camp assault, revealing poor suitability for long blades.
- Redglass shields protect a caravan guard from firebombs, revealing thermal resistance.
- Redglass armor performs well defensively but is hard to produce, confirming workability concerns.
- A rushed project underperforms, teaching the player that research or specialist forging would have mattered.

Field discovery should usually be tied to actual combat context. A fire-resistance property should reveal faster when fire is present. A weapon-suitability flaw should reveal faster when weapons are used in battle.

Design principle:

> Prototype combat should be simple enough to build, but rich enough that weapons, armor, route defense, raider pressure, and field discovery all touch the same loop.

### 13.24 Prototype Squad Manpower and Equipment Model

For v0.1, squads should be simple physical entities on the strategic map. They do not need internal tactical composition, formation logic, ammunition, morale, fatigue, or per-soldier inventory yet. The prototype only needs enough squad structure to support movement, supply consumption, equipment assignment, guarding, escorting, scouting, and abstract combat.

Design principle:

> Squads are map entities with manpower, supply needs, movement speed, assignment state, and equipment coverage. Their combat value changes based on how many soldiers are equipped, not because the squad becomes a different abstract card.

#### Squad as a Map Entity

Each squad exists as a visible entity on the strategic map. It can be selected, inspected, moved, assigned, and targeted.

Minimum squad fields:

| Field | Prototype Meaning |
|------|-------------------|
| **Name** | Human-readable squad identity, such as Hearthmere Militia or Roadwardens |
| **Manpower** | Number of soldiers represented by the squad |
| **Location** | Current region, route, caravan, guard post, mine, or settlement |
| **Assignment** | Idle, moving, guarding, escorting, scouting, patrolling, attacking, or recovering |
| **Base Attack** | Combat value before equipment modifications |
| **Base Defense** | Defensive value before equipment modifications |
| **Movement Speed** | How quickly the squad moves on routes |
| **Supply Use** | Supplies consumed over time while active or away from Hearthmere |
| **Condition** | Readiness state for v0.1: Ready, Wounded/Recovering, or Killed/Destroyed |
| **Equipment Coverage** | How many soldiers have usable weapons and armor/shields |

The squad should be treated as one entity for v0.1. The player does not need to manage individual soldiers.

#### Squad Lifecycle

For v0.1, squads should not split or recombine in the field. Because prototype soldiers do not yet have individual experience, traits, injuries, personalities, or equipment histories, splitting squads would add interface and balance complexity before it creates meaningful attachment.

Prototype rule:

> Squads cannot split or recombine in v0.1. A squad may only be dissolved at Hearthmere or another valid home base, returning its surviving manpower and equipment to local pools.

Allowed lifecycle actions:

- **Create squad** at Hearthmere if manpower, equipment, supplies, and capacity are available.
- **Assign equipment** from the local armory or finished equipment stockpile.
- **Send squad** to move, guard, escort, scout, patrol, attack, or recover.
- **Return home** to recover, resupply, or change assignment.
- **Dissolve squad** only at Hearthmere/home base, freeing surviving manpower and returning usable equipment to the local stockpile.

This gives the player flexibility without requiring detailed unit composition. Long-term, squad identity, veterancy, injuries, traits, banners, and tactical roles may make splitting/reforming more meaningful, but that is not required for the first prototype.

#### Direct Command and Assignment

Squads support both direct movement and assignment-based behavior.

Direct commands:

- move to region
- move along route
- return to Hearthmere
- attack visible raider unit or camp
- withdraw if possible

Assignments:

- guard the mine
- escort a caravan
- scout a region or route
- patrol an area
- establish or staff a temporary guard post
- recover at Hearthmere

Assignments should cause the squad to behave physically. A squad assigned to escort a caravan moves with the caravan. A squad assigned to guard the mine stays at or near the mine. A squad assigned to scout a pass expands player knowledge in that area over time and may reveal raider movement earlier.

#### Manpower and Supply Use

Manpower determines both combat scale and supply demand. Larger squads are stronger, but they consume more supplies and are harder to keep active away from Hearthmere.

Prototype rule:

> More soldiers means more combat power, but also more logistical burden.

For v0.1, exact numbers can be tuned later, but the relationship should be simple:

- each squad has a manpower count,
- supply use scales with manpower,
- moving, escorting, scouting, patrolling, and attacking consume more supplies than local idle defense,
- squads can carry a small supply buffer for short operations,
- longer operations require access to a local stockpile, friendly settlement, guard post, or supply route,
- insufficient supplies reduce effectiveness, halt the current assignment, or force withdrawal.

This reinforces the logistics fantasy: military activity is not free. A squad can physically move anywhere it can reach, but keeping it useful requires supplies. Supply lines are not abstract support ranges; they are physical goods moving through vulnerable routes.

#### Equipment Coverage

For v0.1, equipment should modify squad strength proportionally based on how many soldiers are equipped.

The prototype does not need multiple weapon classes or armor classes yet. Use broad categories:

- basic weapons
- basic armor/shields
- Redglass weapons
- Redglass armor/shields

A squad can be partially equipped. If a 20-soldier squad receives 10 sets of Redglass weapons, only half the squad benefits from the Redglass weapon modifier.

Example:

```text
Squad Manpower: 20
Redglass Weapons Available: 10
Weapon Coverage: 50%
Effective Attack Bonus: 50% of full Redglass weapon bonus
```

Likewise, armor/shield benefits should scale with the number of soldiers equipped.

This lets armory stockpiles matter without requiring per-soldier gear management.

#### Base Soldier Template

The prototype can define a simple base soldier profile and let squad values scale from it.

Example prototype structure:

```text
Base Soldier
- Attack: 1
- Defense: 1
- Supply Use: 1 per interval when active away from Hearthmere
- Movement: normal when lightly equipped
```

A squad's base values derive from manpower:

```text
Squad Base Attack = Manpower × Base Soldier Attack
Squad Base Defense = Manpower × Base Soldier Defense
Squad Supply Use = Manpower × Base Soldier Supply Use × Assignment Modifier
```

Equipment then modifies those values proportionally based on coverage.

#### Movement Speed and Burden

Squads should have movement speed. For v0.1, speed can be simple but should leave room for future equipment weight, terrain, roads, weather, and supply conditions.

Minimum movement influences:

- route length,
- route terrain,
- current assignment,
- equipment burden if implemented,
- supply status.

Speed should also support basic combat-context outcomes:

- fast squads can intercept or respond sooner,
- slow caravans have poor escape chances,
- light raider parties can shadow, ambush, and withdraw,
- defeated remnants may escape if they are faster or can abandon cargo,
- heavily equipped or supply-burdened squads may move slower.

Heavy armor does not need a detailed fatigue system in v0.1. If weight matters at all, it can be represented as a simple movement penalty or supply-use increase.

Avoid building a deep fatigue or encumbrance model until tactical combat and detailed army logistics need it.

#### Starting Squad Recommendation

For v0.1, Hearthmere should probably start with one flexible militia/guard squad rather than many specialized units.

Recommended starting squad:

```text
Hearthmere Militia
- Manpower: enough to guard one thing well or cover multiple things poorly
- Basic weapons: enough for most or all soldiers
- Basic armor/shields: partial coverage
- Carried supplies: enough for a short assignment away from Hearthmere
- Assignment options: guard, escort, scout, patrol, attack, recover
```

The player may later create additional squads if Hearthmere has enough free manpower, equipment, supplies, and commitment capacity. For v0.1, creating a new squad should be a home-base action, not something done in the field.

Squads should not split or recombine in v0.1. If the player wants to reorganize, they must return a squad to Hearthmere, dissolve it if desired, and create new squads from the returned manpower and equipment.

#### Prototype Combat States

Combat states should stay minimal until the tactical combat system exists.

Recommended v0.1 states:

| State | Meaning |
|------|---------|
| **Ready** | The squad can move, guard, escort, scout, patrol, or attack normally. |
| **Wounded / Recovering** | The squad survived but has reduced effectiveness and should return to Hearthmere or a safe support location to recover. This is included in v0.1 because it creates meaningful consequences without requiring full morale, injury, or tactical systems. |
| **Killed / Destroyed** | The squad has been eliminated as an effective force. Surviving equipment, if any, may be recoverable depending on combat context. |

A morale, rout, panic, cohesion, or broken-state system is not required for v0.1. Those systems may become important later, especially once battles are tactical and squads have identity, veterancy, and battlefield behavior.

For the prototype, a combat result can simply report:

```text
Result: Victory / Defeat / Withdrawal
Returned Ready: X
Wounded / Recovering: Y
Killed: Z
Condition: Ready or Wounded/Recovering
Equipment Lost or Recovered: optional
Discovery Progress: optional
```

#### Casualty and Combat-Result Display

Because population is the source of both labor and military manpower, combat results should show population consequences clearly. The player should understand that casualties are not abstract damage on a unit card; they are people removed from Hearthmere's workforce and future military capacity.

For v0.1, every combat result should separate survivors into three simple categories:

| Result Category | Meaning | Economy Effect |
|----------------|---------|----------------|
| **Returned Ready** | Survivors who can keep operating or return to work if the squad is dissolved at Hearthmere | Remain available as mobilized manpower or can return to the workforce after normal demobilization friction |
| **Wounded / Recovering** | Survivors temporarily unable to fight or work effectively | Move into the recovery pool; return after recovery time at Hearthmere or another safe recovery location |
| **Killed** | Permanent deaths | Reduce total population and future available workforce |

This keeps the casualty model simple while making losses meaningful. A squad can win a fight but still return with wounded people who temporarily reduce Hearthmere's productive capacity. A bad defeat can permanently reduce population, lower available workforce, shrink labor-team capacity, and make later projects harder to sustain.

Minimum combat-result screen fields:

```text
Outcome: Victory / Costly Victory / Partial Failure / Defeat
Objective Result: Cargo delivered, cargo stolen, mine protected, camp damaged, etc.
Returned Ready: X
Wounded / Recovering: Y
Killed: Z
Population Change: -Z
Workforce Impact: X labor unavailable, Y recovering, etc.
Equipment Result: recovered, lost, damaged, or unchanged
Cargo / Stockpile Result: delivered, stolen, destroyed, or delayed
Supply Result: supplies consumed, lost, or captured
Discovery Result: none, progress gained, or Codex entry updated
Next Suggested Action: return to Hearthmere, resupply, recover, pursue, reroute, etc.
```

The combat-result screen should prioritize consequences over drama. It should tell the player what happened, what was lost, what remains usable, and how the result changes the next strategic decision.

Example:

```text
Caravan Ambush — Costly Delivery
The caravan reached Hearthmere, but the escort was badly hurt holding the pass.

Cargo: 8 Redglass Ore delivered
Returned Ready: 11
Wounded / Recovering: 6
Killed: 3
Population: -3
Workforce Impact: 6 recovering, 20 still mobilized until demobilized
Equipment: 2 basic shields lost
Supplies: 4 consumed, 2 lost
Discovery: Redglass shield plates gained field data under firebomb exposure
```

Design principle:

> Combat results should turn battlefield outcomes into population, labor, supply, equipment, cargo, and discovery consequences.

#### Wounded Recovery Requirement

For v0.1, wounded recovery should require **time only**. Wounded people must be back at Hearthmere or another valid safe recovery location, but the prototype does not need to consume supplies, medicine, healer capacity, or hospital resources to return them to service.

Prototype rule:

> Wounded recovery is a time-based delay, not a supply-management sub-system.

This keeps the casualty model simple while still creating a meaningful consequence. Wounded soldiers are not dead, but they are temporarily unavailable for work, scouting, guarding, escorting, or future military action. The player must decide whether to wait for them, mobilize more people, or continue operating with reduced capacity.

Suggested starting values:

| Wound Severity / Result | Recovery Target |
|---|---:|
| Lightly wounded after a favorable fight | 12–24 hours |
| Wounded after a costly fight | 24–48 hours |
| Badly wounded after a major defeat | 48–72 hours |

These values are tuning placeholders. The important rule is that wounded people return through time and safety, not through an additional prototype resource cost.

Long-term, recovery can become deeper. Future systems may include medical supplies, healers, temples, hospitals, disease, trauma, disability, prisoner rescue, magical healing, recovery quality, and supply shortages affecting survival. Those are intentionally deferred so v0.1 can focus on the core loop of population loss, temporary unavailability, and strategic opportunity cost.

#### What v0.1 Does Not Need Yet

Do not implement these unless they become necessary:

- multiple weapon types,
- separate infantry/archer/cavalry roles,
- split/recombine squad management,
- morale,
- rout/broken-state systems,
- fatigue,
- ammunition,
- detailed injuries,
- formations,
- per-soldier gear,
- training levels,
- experience/veterancy,
- full tactical-map stat blocks.

Those systems belong later, especially once FFT-style tactical battles become part of the game.

For now, the key question is whether physical squads, equipment coverage, supply consumption, simple combat states, and assignments create interesting strategic pressure on the map.

### 13.25 Prototype Scenario End Conditions and Victory Paths

AXIOM should not treat victory as simply painting the map the player's color. Long-term victory can come from dominance, mastery, divine favor, coalition success, dynastic endurance, magical transformation, relic discovery, or other world-specific objectives. The prototype should reflect that philosophy in a small, buildable form.

For v0.1, scenario endings should be framed as **local resolutions**, not full grand-strategy victories. The player is not winning the whole world. They are resolving the first crisis around Hearthmere, the Redglass discovery, and Blackbanner pressure.

Design principle:

> Even the prototype should imply that AXIOM has multiple paths to success. Military victory is valid, but it should not be the only imaginable form of victory.

#### Primary Prototype Victory — Clear the Raider Stronghold

The clearest v0.1 win condition is military:

> The player defeats or disperses the Blackbanner raider stronghold.

This can happen by directly attacking Blackbanner Camp after preparing a militia squad, forging useful equipment, scouting the camp, or weakening raider forces through defensive victories.

This victory tests:

- weapon and armor payoff
- squad command
- scouting and visibility
- raider map entities
- abstract combat resolution
- field discovery under stress
- the player's ability to turn material knowledge into military advantage

The scenario should end with a summary explaining how the player won and what role the Redglass discovery played.

Example summary:

> Hearthmere's militia broke the Blackbanner camp before the raiders could organize another strike. Redglass equipment proved decisive, though its full nature remains only partly understood.

#### Secondary Prototype Victory — Secure the Ore Chain

A non-conquest v0.1 win condition can focus on logistics and defense:

> The player keeps Hearthmere safe, protects the mine, completes the first Redglass equipment project, and successfully maintains the ore route through at least one major raider threat.

This victory does not require destroying the raider camp. It represents stabilizing the local situation well enough that the first crisis has passed.

This victory tests:

- mine claiming and protection
- caravan routing
- escorts and guard assignments
- route choice
- stockpile risk
- weapons-vs-armor commitment
- defensive use of material discovery

This path is useful because it lets armor, guards, scouting, and cautious logistics feel like a legitimate strategy rather than a delay before the mandatory camp assault.

Example summary:

> Hearthmere secured the Redglass supply chain. The raiders remain in the hills, but the mine is guarded, the route is functioning, and the settlement has turned discovery into a defensible advantage.

#### Optional Prototype Victory — Discovery Breakthrough

If implementation allows, v0.1 can include a discovery-focused ending:

> The player identifies the strange ore's key physical and magical behavior, completes a successful equipment application, and documents the discovery in the Material Codex before the ore chain collapses.

This should not require a full scientific victory system. It can be a simple local objective: reach the first major Redglass understanding threshold and prove it through either research, field use, or both.

This victory tests the core thesis most directly:

- prospecting
- material uncertainty
- research vs immediate forging
- hybrid discovery progress
- codex updates
- field discovery
- adaptation based on knowledge

This should probably be a secondary or bonus ending for the prototype, not the only win condition.

Example summary:

> Hearthmere's scholars and soldiers have identified the first true law of Redglass. The material is no longer merely strange; it is now a strategic tool.

#### Future / Post-Prototype Victory Directions

The prototype may hint at richer future victory paths without implementing them. Future scenario or campaign goals could include:

- clearing a hostile stronghold
- finding and securing an ancient relic
- achieving enough favor with a deity to receive intervention
- reaching magical ascension or transformation
- mastering a rare material family
- surviving a Legacy Empire crisis
- stabilizing a collapsing neighbor
- building a coalition against a larger threat
- preserving faction identity through a dangerous age

These should remain out of v0.1 unless they can be represented with extremely simple placeholders. The prototype's job is to imply the design space, not build the whole victory system.

#### Defeat Conditions

The prototype should include clear defeat conditions, but setbacks should not all be instant losses. A raided caravan, stolen sample, damaged mine, or failed equipment choice should usually create a recovery problem. Defeat should occur when the local crisis reaches Hearthmere and the player can no longer protect the settlement.

Primary v0.1 defeat:

> The Blackbanner raiders defeat Hearthmere's capital defenses and sack or pillage the settlement.

Possible paths to defeat:

- raiders gather enough strength and attack Hearthmere successfully
- the militia is destroyed or routed and no defensive force remains
- repeated raids collapse the ore chain and leave Hearthmere unable to prepare
- the mine and shipments are lost badly enough that the player cannot recover before the settlement attack

Defeat summary example:

> Hearthmere was sacked before its people could turn Redglass into an advantage. The discovery drew attention faster than the settlement could adapt.

#### Fail-Forward Setbacks

Not every bad outcome should end the scenario. These should be serious setbacks, not immediate failure:

- first caravan ambushed
- ore sample stolen
- mine stockpile raided
- prospect site turns out barren
- rushed weapons perform poorly
- armor proves too heavy or flawed
- field discovery reveals a weakness
- raiders escape after a skirmish

The player should be able to recover from at least some of these by adapting: changing routes, assigning guards, switching from weapons to armor, waiting for research, attacking a smaller raider party, or pausing extraction until the route is safer.

#### Scenario End Summary

Every ending should produce a short summary that reinforces AXIOM's core thesis:

- What did the player discover?
- How did they use or misuse that knowledge?
- What happened to the ore chain?
- What happened to Hearthmere?
- What remains unresolved in the wider world?

The summary should make the player want to try again with a different material roll, prospecting priority, equipment choice, route plan, or military posture.


### 13.26 Prototype Resource, Population, and Starting Asset Model

The resource and asset model is foundational to AXIOM. It should not be treated as background economy. Resources determine what the player can sustain, where they must take risks, what they can specialize in, and how the world creates pressure without artificial caps.

At the same time, v0.1 should avoid pretending the full economy is solved. Starting values should be minimal and adjustable. Anything that can reasonably begin at zero should begin at zero so the prototype tests whether the player can build momentum from an imperfect starting position.

#### Core Design Principle

> The player should begin with local knowledge and latent capacity, not a pile of ready-made assets. They should have people, a settlement, basic production potential, and visible opportunities — but few finished stockpiles or field forces.

The player should not begin with a blank map, but they also should not begin with a solved opener. The opening question is:

> Given what my people already know about the surrounding land, what should I invest in first?

#### Population Is the Root Resource

Population should not be only a background cap. Population is the root resource that labor, manpower, recovery, settlement resilience, and long-term faction survival all come from.

The player is not spending anonymous unit tokens. They are committing people.

People can:

- work,
- fight,
- scout,
- haul,
- build,
- recover,
- migrate,
- flee,
- starve,
- be captured,
- or die.

Repeated military losses should permanently weaken the settlement unless offset by migration, rescued captives, conquest, integration of other settlements, or long-term population growth.

The core population question is:

> How many people does Hearthmere have, how many can work, how many can fight, and how badly do repeated losses damage the settlement's future?

#### v0.1 Population Values

For v0.1, Hearthmere should track a small number of population-related values:

| Value | Meaning |
|---|---|
| **Total Population** | Everyone living in Hearthmere. This includes workers, dependents, local defenders, children, elderly, and noncombatants. |
| **Available Workforce** | The portion of the population currently available for labor, projects, hauling, surveying, construction, supply work, or military service. |
| **Labor Teams** | Player-facing abstraction of available civilian work capacity. Used for projects and facilities instead of assigning individual workers. |
| **Mobilized Manpower** | People currently serving in mobile squads, escorts, patrols, scouts, guard posts, or military assignments. |
| **Wounded / Recovering** | Temporarily unavailable people. They are still part of the population but cannot work or fight until recovered. |
| **Dead / Missing / Captured** | People removed from the available pool. Dead are permanent losses. Missing and captured may return through events, rescue, ransom, or post-battle recovery. |

For the first prototype, the UI does not need to show deep demographic categories such as children, elderly, class, profession, family, or household. Those can come later.

Recommended v0.1 visible summary:

```text
Hearthmere Population: 240
Available Workforce: 120
Labor Teams: 6
Mobilized Manpower: 0
Recovering: 0
Recent Losses: 0
```

#### Population Loss

Population should go down when people die.

For v0.1, the main population-loss sources are:

- soldiers killed in combat,
- civilians killed during raids,
- settlement sack or pillage,
- workers killed during mine attacks,
- scouts or caravaneers killed during ambushes.

Long-term, additional population-loss sources may include famine, disease, magical disaster, forced migration, divine punishment, winter exposure, siege conditions, massacre, forced conscription, or population flight.

Combat should distinguish between killed and wounded. Not every casualty is a death.

Example result:

```text
Battle result:
- 4 killed
- 6 wounded
- 10 returned ready
```

Killed people permanently reduce the population and workforce potential. For v0.1, wounded people temporarily occupy the recovery pool and return after enough recovery time at Hearthmere or another safe recovery location. Supplies, medicine, healer capacity, hospital buildings, and recovery quality can be added later, but the prototype only needs time-based recovery.

Design rule:

> Losing a squad is not just losing a military card. Hearthmere lost people.

This makes repeated military failure economically meaningful. If the player continuously raises squads and gets them killed, the settlement should dwindle. Labor teams should eventually fall, projects should slow, military recovery should become harder, and the player should feel the demographic consequences of reckless warfare.

#### Population Recovery and Growth

For v0.1, there should be no meaningful passive birth-based population growth. The prototype scenario covers days or weeks, not generations. Children born during the scenario do not become miners, smiths, haulers, or soldiers in time to matter.

Population can increase in v0.1 only through concrete world events, such as:

- rescued captives joining or returning to Hearthmere,
- refugees arriving from unsafe nearby regions,
- families from Westmere Farms seeking protection,
- workers returning after being missing,
- prisoners being freed from Blackbanner Camp,
- neutral locals joining after the road becomes safe.

Example:

```text
Event: Families from Westmere Farms seek protection in Hearthmere.
+24 Population
+8 Available Workforce after 24 hours
Supply consumption pressure increases.
```

Population gain should not be pure upside. More people increase labor potential, but they also increase supply demand, housing pressure, vulnerability during siege, and the stakes of defending Hearthmere.

Long-term campaign population growth should come from two layers:

1. **Natural growth** — slow, background growth based on food surplus, health, housing, safety, fertility, culture, disease, divine favor, season, and settlement stability.
2. **Migration / attraction** — faster and more player-influenced growth based on safety, prosperity, available work, food security, religious/cultural appeal, roads, protection, trade, and opportunity.

Migration should be the main player-facing population growth lever. The player should not click “increase population.” The player should create conditions that make people want or need to come.

People should move toward places that are safe, fed, prosperous, spiritually attractive, politically stable, protected, and full of opportunity. People should leave places that are starving, raided, overtaxed, losing wars, cursed, unstable, unsafe, occupied, or hostile to their culture/religion.

#### Labor Teams and Available Workforce

Labor is the player's most important early constraint. For v0.1, labor should use a hybrid model.

Internally, Hearthmere can track population and available workforce numerically. Player-facing management should use labor teams.

Example:

```text
Hearthmere Population: 240
Available Workforce: 120
Labor Team Size: 20 workers
Available Labor Teams: 6
```

Labor teams can be assigned to sustained activities:

```text
Survey prospect: 1 labor team
Claim deposit: 1 labor team
Establish mine: 2 labor teams
Operate mine: 1 labor team
Produce supplies: 1 labor team
Forge project: 1 labor team
Academy analysis: 1 labor team
Prepare basic weapons or armor: 1 labor team
```

This gives population mechanical weight without requiring individual worker micromanagement.

If the available workforce drops below a threshold because of deaths, wounds, capture, migration loss, famine, or over-mobilization, available labor teams should drop.

Example:

```text
Before losses:
Population: 240
Available Workforce: 120
Labor Teams: 6

After repeated military losses:
Population: 208
Available Workforce: 96
Labor Teams: 4
```

This creates the intended strategic consequence:

> I can raise another squad, but if I lose these people too, Hearthmere may not have enough workers left to run the mine, produce supplies, and defend itself.


#### Labor Assignment Friction and Continuity

Labor should be flexible, but not liquid. The player should be able to reassign people between work, military service, and emergency needs, but doing so should have a cost in time, output, readiness, or efficiency.

The design problem to avoid is instant social shapeshifting: the player disbands armies into labor projects during quiet periods, then reforms them into armies exactly when danger appears, with no downside. That would make population feel like a perfectly efficient resource pool rather than a living settlement with habits, training, tools, organization, and disruption costs.

Prototype rule:

> Labor teams and military squads can be reassigned, but reassignment should create friction. People can change roles, but they do not become instantly optimized for the new role.

For v0.1, this can stay simple. Reassignment friction does not need deep profession simulation or individual worker tracking. It can be represented through one or more lightweight rules:

1. **Home-base conversion only**
   Mobile squads can only be dissolved at Hearthmere or another valid home base. This prevents the player from turning soldiers into miners in the field or instantly converting remote labor into a mobile army.

2. **Mobilization time**
   Creating a squad from available workforce takes time. Improvised militia can form quickly but perform poorly. Proper watch squads require equipment preparation and more time.

3. **Demobilization delay**
   Dissolving a squad returns surviving manpower, but not necessarily as immediately productive labor. People may need time to rest, reorganize, return tools, recover from field conditions, or resume civilian work.

4. **Project disruption**
   Pulling a labor team off a project pauses or slows that project. Some progress may be preserved, but efficiency should suffer if the player constantly swaps assignments.

5. **Continuity bonus**
   A labor team or facility that remains staffed without interruption may become more efficient over time. This represents workers learning the site, improving routines, understanding local hazards, and building practical expertise.

6. **Emergency conversion penalty**
   In a crisis, the player may be able to raise emergency defenders quickly, but they should be less effective than trained or properly equipped squads and may disrupt local production more severely.

For the first prototype, the safest implementation is:

```text
- Labor teams are assigned in chunks.
- Squads are created/dissolved only at Hearthmere.
- Creating a squad takes time and removes workforce.
- Dissolving a squad returns surviving manpower after a short delay.
- Projects pause when their assigned labor is removed.
- Optional: uninterrupted work grants a small efficiency bonus after several days.
```

This preserves player agency while making role changes consequential. If the mine is active, the academy is being built, and a squad is mobilized, there may be no free labor left. The player can respond to a crisis by pulling people from the mine or academy, but that choice visibly slows extraction, delays construction, disrupts research, or reduces supply production.

Long-term, this can grow into a deeper workforce system. Workers may develop occupational familiarity, military units may gain training and identity, specialists may anchor facilities, and regions may develop local expertise. For v0.1, the only required lesson is:

> People can be reassigned, but society has inertia. Moving people from work to war and back should solve one problem while creating another.

#### Manpower and Military Service

Military manpower comes from the same population base as labor.

Creating a mobile squad removes manpower from the civilian workforce. Dissolving a squad at Hearthmere returns surviving manpower. Wounded squad members return only after recovery. Killed soldiers do not return.

Example:

```text
Create Improvised Militia Squad
- Requires: 20 manpower
- Removes: 20 available workforce
- Equivalent opportunity cost: 1 labor team
```

Before squad creation:

```text
Population: 240
Available Workforce: 120
Labor Teams: 6
Mobilized Manpower: 0
```

After squad creation:

```text
Population: 240
Available Workforce: 100
Labor Teams: 5
Mobilized Manpower: 20
```

After a bad battle:

```text
Result:
- 8 killed
- 5 wounded
- 7 ready survivors

Population: 232
Available Workforce potential reduced by 8
Recovering: 5
Mobilized Manpower: 7
```

This model makes fielding soldiers a real economic decision. The player is not merely building armies; they are converting the settlement's productive people into military risk.

#### Settlement Defense vs. Mobile Squads

If starting field squads and armory stockpiles begin at zero, Hearthmere still needs an abstract local defense value so the first raider event does not instantly end the scenario.

For v0.1, distinguish between:

**Settlement Defense**  
An immobile local defense value representing walls, town watch, able-bodied residents, improvised weapons, local terrain, and emergency defense. It protects Hearthmere but cannot leave the settlement.

**Mobile Squads**  
Physical units created by assigning manpower and equipment. They can scout, escort, guard remote sites, patrol routes, attack raiders, or establish temporary guard posts.

This allows Hearthmere to begin without a mobile army while still making the decision to create one meaningful.

#### First Squad Creation When Armory Stockpiles Start at Zero

The current v0.1 direction is:

```text
Starting mobile field squads: 0
Starting spare basic weapons: 0
Starting spare basic armor/shields: 0
Settlement defense: present, abstract, immobile
```

This creates a potential problem: the player still needs early agency. The solution is to allow weak improvised squads while making proper equipment matter.

The first build should support three early military paths:

1. **Improvised Militia**
   - Requires manpower.
   - Requires no stored weapons or armor.
   - Weak attack and weak defense.
   - Can scout, guard, escort, delay raiders, or respond to emergencies.
   - Bad at camp assault and risky in serious combat.

2. **Proper Watch Squad**
   - Requires manpower.
   - Requires basic weapons.
   - Armor/shields optional but valuable.
   - Takes forge labor and time to prepare.
   - Reliable enough for escort, mine defense, patrol, and early skirmishes.

3. **Redglass-Equipped Squad**
   - Requires manpower.
   - Requires Redglass delivered to Hearthmere.
   - Requires a forge project.
   - Stronger or stranger, depending on discovered and hidden material behavior.
   - Riskier if forged with incomplete knowledge.

This creates an early strategic choice:

> Field weak manpower now, spend time making reliable basic gear, or gamble on strange-material equipment.

#### Mobilization Timing and Warning Windows

Creating a mobile squad should take time. The player should not be able to click an instant army into existence the moment danger appears. A spotted threat is the warning; the time it takes that threat to reach its target is the player's response window.

Prototype rule:

> Mobilization is a project, not an instant button. Threat visibility gives the player time to respond, but preparation still consumes hours, labor, supplies, and attention.

For v0.1, use simple mobilization timings as starting tuning targets:

| Mobilization Action | Initial Target | Purpose |
|---|---:|---|
| **Raise Improvised Militia** | 4–8 hours | Emergency mobile force; weak but fast to organize |
| **Prepare Proper Watch Squad** | 12–24 hours | More reliable guard/escort/patrol squad with basic equipment |
| **Equip Existing Squad at Hearthmere** | 1–2 hours | Applies available weapons/armor to an already-created squad |
| **Dissolve Squad at Hearthmere** | 4–8 hours before full labor return | Prevents instant army-to-labor optimization |

These values are not final balance. Their purpose is to make response timing matter. If raiders are sighted one region away and likely to reach the mine in six hours, the player may be able to raise an improvised militia but probably cannot prepare a proper watch squad in time. If raiders are seen gathering near Blackbanner Camp a day before a likely attack, the player has time to make a more deliberate military preparation.

The warning system should remain diegetic. The game should not say "attack timer: 6 hours" unless the player's information genuinely supports that precision. Instead, the player sees raiders moving, gathering, shadowing a route, or approaching a target. Better scouting can make the response window clearer.

Example warnings:

- A scout spots a small raider party moving toward Ashen Pass.
- A patrol sees raiders gathering near the road to Redglass Foothills.
- A caravan crew reports riders shadowing the route.
- Blackbanner raiders begin moving toward the mine while ore is stockpiled there.

Possible player responses:

- raise improvised militia if time is short,
- prepare a proper watch squad if time allows,
- keep workers on their current projects and rely on Hearthmere's immobile defense,
- abandon or recall a shipment,
- send an existing squad if one has already been prepared,
- or accept the risk and keep investing in discovery, extraction, or research.

If danger is already at the gate, mobile mobilization may be too late. In that case, Hearthmere's immobile settlement defense handles the emergency, while the player feels the consequence of not preparing a field squad earlier.

Design principle:

> The player should prepare because the world gives warning through visible movement, not because armies can appear instantly when clicked.

#### First Squad Creation Flow

The first mobile squad should be created through Hearthmere, not from a global military menu. The action should make clear that the player is converting population and labor capacity into a physical force that can leave home, consume supplies, and potentially die.

Prototype rule:

> The first mobile squad is a settlement project. It pulls people out of the workforce, takes time to organize, and creates a map entity only when mobilization completes.

For v0.1, Hearthmere should support three military-creation paths.

##### 1. Raise Improvised Militia

This is the emergency option. It gives the player a weak mobile squad before proper equipment exists.

Purpose:

- respond to a spotted threat if there is only a short warning window,
- escort a low-value shipment in a pinch,
- scout or delay raiders,
- guard a mine temporarily,
- create early agency when armory stockpiles start at zero.

Prototype requirements:

- available workforce/manpower,
- short mobilization time,
- small supply issue for field use,
- no stored weapons or armor required.

Prototype costs and effects:

```text
Raise Improvised Militia
- Time: 4–8 hours
- Manpower: 20 people
- Workforce impact: -1 labor team while mobilized
- Equipment: improvised/local tools only
- Carried supplies: short field buffer
- Combat role: weak attack, weak defense, useful for scouting, delay, escort, and emergency guard duty
```

Improvised militia should not be good enough to solve every military problem. It is a fast response, not a replacement for preparation. It should be risky against serious raider groups and poor for assaulting Blackbanner Camp.

##### 2. Prepare Proper Watch Squad

This is the reliable early military option. It takes longer because the settlement must gather people, organize command, prepare basic weapons, issue shields or armor if available, and package enough supplies for field duty.

Purpose:

- defend the mine,
- escort valuable caravans,
- patrol Ashen Pass or Old Pine Road,
- establish a temporary guard post,
- win early skirmishes more reliably.

Prototype requirements:

- available workforce/manpower,
- preparation time,
- supplies,
- forge/workshop or militia-yard labor.

Because spare armory stockpiles begin at zero, the first Proper Watch Squad action can abstract the creation of basic equipment as part of the preparation project. The player does not need to run a separate “make mundane spears” project unless implementation later benefits from that extra step.

Prototype costs and effects:

```text
Prepare Proper Watch Squad
- Time: 12–24 hours
- Manpower: 20 people
- Workforce impact: -1 labor team while mobilized
- Preparation labor: 1 labor team or workshop/militia-yard capacity during the project
- Supplies: enough to issue a short field buffer
- Equipment: basic weapons; partial basic shields/armor if the project completes cleanly
- Combat role: reliable escort, mine guard, route patrol, and early skirmish force
```

The Proper Watch Squad should be meaningfully better than improvised militia, but it should cost enough time that the player cannot always wait for it after raiders are already close.

##### 3. Upgrade or Equip Existing Squad

Once a squad exists and is physically present at Hearthmere, the player may equip it with available gear.

Prototype uses:

- issue basic gear from stockpile if any exists later,
- equip Redglass weapons,
- equip Redglass armor/shields,
- replace improvised gear with proper gear,
- prepare a squad for a specific mission.

Prototype costs and effects:

```text
Equip Existing Squad at Hearthmere
- Time: 1–2 hours
- Requires: squad present at Hearthmere
- Requires: equipment present in Hearthmere stockpile
- Effect: updates equipment coverage proportionally
```

Equipment should not teleport to field squads in v0.1. If a squad is guarding the mine and Redglass armor is completed at Hearthmere, the squad must return to Hearthmere or the equipment must be shipped forward in a later system. For the first prototype, requiring return to Hearthmere is simpler.

##### Dissolve Squad

Dissolving a squad should also be a Hearthmere action. It should not happen instantly in the field.

Prototype costs and effects:

```text
Dissolve Squad at Hearthmere
- Time: 4–8 hours
- Returns: ready surviving manpower to available workforce after demobilization
- Returns: usable equipment to local stockpile
- Does not return: killed people
- Wounded: remain in recovery until healed
```

This prevents the player from perfectly cycling population between labor and armies with no friction. The player can demobilize, but there is a delay and any current assignments end.

##### UI Placement

The first squad actions should appear in the Hearthmere settlement panel, likely under a simple **Militia / Manpower** or **Defense** subsection.

Minimum buttons:

- **Raise Improvised Militia**
- **Prepare Proper Watch Squad**
- **Equip Squad** if a squad and equipment are present
- **Dissolve Squad** if a squad is present at Hearthmere
- **Recover** or **Rest** if wounded survivors are present

Each button should show what it consumes before the player confirms:

- manpower removed from available workforce,
- labor team impact,
- time required,
- supplies issued,
- expected squad role,
- and whether current projects will be paused or slowed.

##### Strategic Purpose

The first squad flow should create a real choice:

> Do I pull people out of work now for a weak emergency force, spend time creating a proper watch squad, or keep my population working while relying on settlement defense and scouting?

This also supports the anti-micromanagement goal. The player may convert labor into military force, but every conversion takes time, interrupts work, consumes supplies, and risks population loss.

Design principle:

> Military readiness is not a toggle. It is a commitment of people, time, supplies, and opportunity cost.


#### Relative Squad Strength Targets

The first prototype does not need final combat numbers before the full combat context exists. Instead, squad strength should be defined by **expected matchup behavior**. Numbers can then be tuned until those matchups feel right.

Prototype rule:

> Balance early squads by what they should be able to handle, not by pretending the first numeric values are final.

For v0.1, the important comparison is between Hearthmere forces and Blackbanner raiders.

##### Baseline Enemy: Basic Raider Squad

A Basic Raider Squad is the normal early hostile unit. It represents a small mobile raider party able to scout, shadow caravans, raid exposed stockpiles, and fight improvised defenders.

Prototype role:

- threaten unescorted caravans,
- threaten an unguarded mine stockpile,
- fight improvised militia on roughly even terms,
- lose or withdraw against a prepared watch squad unless it has advantage,
- contribute to a larger threat if several raider squads gather.

The Basic Raider Squad is the main yardstick for early combat balance.

##### Improvised Militia Target

Improvised Militia should be roughly equal to a Basic Raider Squad in a fair fight, but less reliable because they are hastily organized and poorly equipped.

Expected behavior:

- one Improvised Militia squad can contest one Basic Raider Squad,
- the outcome should be uncertain or costly if fought away from Hearthmere,
- militia can delay, discourage, or sometimes repel raiders,
- militia should not comfortably clear Blackbanner Camp,
- militia should not survive repeated fights without rest or losses.

At Hearthmere, the situation changes because immobile settlement defense supports the militia. Improvised Militia plus Hearthmere's static defenses should usually repel an early basic raid, but with meaningful losses if the player is unprepared or undersupplied.

Target player feeling:

> I can raise bodies quickly enough to respond, but these are my people with improvised gear. They can buy time or defend home, not solve the raider problem alone.

##### Proper Watch Squad Target

A Proper Watch Squad should be clearly stronger than a Basic Raider Squad. It represents people who have been organized, supplied, and given basic weapons/shields rather than thrown together in an emergency.

Expected behavior:

- one Proper Watch Squad should usually defeat one Basic Raider Squad,
- it should be able to defeat or drive off a couple of Basic Raider Squads in succession before needing rest/recovery,
- it should be reliable for caravan escort, mine defense, route patrol, and guard-post duty,
- it should still suffer losses if ambushed, outnumbered, undersupplied, or forced into repeated engagements,
- it should not automatically clear Blackbanner Camp without preparation, scouting, or equipment advantage.

Target player feeling:

> Spending time to prepare a real watch squad was worth it. It gives me local control, but it is still a finite force that can be worn down.

##### Redglass-Equipped Squad Target

Redglass equipment should not simply make a squad generically better at everything. Its value depends on whether the player chose weapons or armor, what properties have been discovered, and what combat context appears.

Expected behavior:

- Redglass weapons should make offensive actions and camp assaults more appealing if the material proves weapon-suitable,
- Redglass armor/shields should make escorts, mine guards, and settlement defense more reliable if the material proves armor-suitable,
- fire-resistant Redglass gear should matter strongly in firebomb/fire-exposure conflicts,
- flawed or poorly matched Redglass equipment should still teach the player something through field use,
- Redglass should let the player exploit a world-specific advantage, not replace all strategy.

Target player feeling:

> I discovered what this material is good for, and now I can bend my strategy around that advantage.

##### Repeated Combat and Rest

Even when a squad is favored, repeated combat should wear it down. A Proper Watch Squad may be stronger than basic raiders, but it should not be able to patrol forever, fight every battle, escort every caravan, and assault the camp without recovery.

For v0.1, this can be represented through simple outcomes rather than deep morale/fatigue systems:

- manpower losses,
- wounded/recovering survivors,
- reduced condition after a costly fight,
- supply depletion,
- forced return to Hearthmere to rest or recover.

This preserves the intended logistics/economy pressure: a strong squad is an investment, not a permanent all-purpose solution.

##### Suggested Initial Combat Tuning Targets

Exact numbers should be adjusted during playtesting, but a first pass can use relative score expectations like this:

| Matchup | Desired Result |
|---|---|
| Improvised Militia vs. Basic Raider Squad, neutral ground | roughly even; high chance of losses |
| Improvised Militia + Hearthmere static defense vs. Basic Raider Squad | defenders favored; decent losses possible |
| Proper Watch Squad vs. Basic Raider Squad | watch squad favored |
| Proper Watch Squad vs. two Basic Raider Squads in succession | likely survives, but should need rest/recovery afterward |
| Proper Watch Squad vs. multiple gathered raider squads | risky or unfavorable without equipment/scouting advantage |
| Redglass weapon squad vs. raider camp | improved assault chance if material is weapon-suitable |
| Redglass armor/shield squad defending caravan/mine | improved survival and cargo protection if material is armor-suitable |

Do not overfit these values before the prototype is playable. The purpose of these targets is to define what the first combat numbers should be trying to achieve.

Design principle:

> Early military balance should be legible through matchups: militia can answer immediate danger, watch squads create local control, and discovered material advantages let the player specialize.

#### Supplies

Supplies are the backbone of the prototype economy. They represent food, tools, rope, feed, medicine, lamp oil, replacement parts, tents, pack animals, mundane equipment, and other operating goods.

Supplies are physical goods, not an abstract maintenance meter.

Minimum v0.1 supply rules:

1. Hearthmere has a local supply stockpile.
2. Hearthmere produces supplies over time when labor is assigned.
3. Hearthmere population consumes supplies only if the prototype needs settlement upkeep pressure; otherwise settlement consumption can be deferred.
4. The Redglass mine consumes supplies while active.
5. Remote squads consume supplies while assigned away from Hearthmere.
6. Guard posts and patrols consume supplies while active.
7. Caravans can carry supplies to mines, squads, or guard posts.
8. Supplies are stored locally and have local storage caps.
9. Raiders can target supply shipments.
10. If remote objects run out of supplies, they slow, pause, weaken, withdraw, or become vulnerable.
11. The player can outpace supply production by running too many remote, industrial, or military activities at once.

Supplies should create expansion pressure. The player may have enough people to open another mine or deploy another squad, but not enough supply production or route safety to sustain them.

#### Local Stockpiles and Physical Caps

The prototype should avoid global inventory. Stockpiles should be local.

Examples:

```text
Hearthmere Supplies: 60 / 100
Redglass Mine Supplies: 8 / 20
Redglass Mine Ore: 12 / 30
Caravan Cargo: 10 Redglass Ore
Hearthmere Redglass Ore: 0
```

Caps should be physical, not arbitrary. Settlements, mines, guard posts, caravans, and facilities can store only so much. Storage limits create decisions about shipment timing, route exposure, and raid risk.

The player should not own an abstract number called Redglass. The player owns Redglass in places.

#### Money / Coin

Money is not required for the first build unless it has a concrete use.

Coin, treasury, barter value, stored wealth, credit, tribute, and trade value are important long-term systems, but if v0.1 has no real buying, hiring, trading, wages, or market decisions, money should be omitted or start at zero.

Money should appear when the player has external actors or systems to pay, such as:

- hiring specialists,
- hiring mercenaries,
- buying supplies,
- buying foreign materials,
- bribing raiders,
- paying wages,
- funding diplomacy,
- paying tribute,
- financing trade,
- rushing construction through paid labor,
- or maintaining markets.

Until then, Hearthmere is not running a cash economy. It is running a population, supply, labor, and logistics economy.

#### Recommended Starting Assets

A first test version of Hearthmere can begin with:

```text
Hearthmere
- Population: 240
- Available Workforce: 120
- Labor Team Size: 20 workers
- Available Labor Teams: 6
- Supplies: 60 / 100
- Supply Production: +12 per day with one labor team assigned
- Settlement Defense: 12, immobile
- Mobile Field Squads: 0
- Basic Weapons Stockpile: 0
- Basic Armor/Shields Stockpile: 0
- Coin: omitted
- Redglass: 0
```

These numbers are tuning placeholders. The goal is not exact balance. The goal is to make the player choose between discovery, preparation, security, supply production, and military projection.

The player starts with capacity, not finished answers.

#### Starting Strategic Choices

The opening economy should immediately create meaningful decisions:

- Survey prospects quickly or scout dangerous routes first.
- Produce supplies now or rely on the starting stockpile.
- Create an improvised squad or wait for proper equipment.
- Prepare the forge or prepare the academy.
- Rush mine setup or establish security first.
- Move small shipments safely or larger shipments efficiently.
- Guard the mine or escort the caravan.
- Forge weapons, forge armor, or delay for research.

The player should not be able to comfortably survey every prospect, operate the mine, run the academy, run the forge, guard the mine, escort every caravan, scout every route, and prepare a camp assault all at once.

#### Population Spiral From Repeated Losses

Repeated military losses should create a population spiral.

If the player continuously loses armies:

1. total population drops,
2. available workforce drops,
3. labor teams drop,
4. projects slow,
5. supply production weakens,
6. fewer escorts and guards are available,
7. routes become harder to secure,
8. remote sites become harder to sustain,
9. raiders become more dangerous,
10. Hearthmere becomes more vulnerable.

This is intentional. The military system should be plugged into the economy. A reckless player should not be able to endlessly replace soldiers from an invisible manpower pool.

The player should eventually face the question:

> Can I afford to risk these people, or does Hearthmere need them alive more than it needs another attack?

#### Population Growth and Player Influence

Long-term, the player should be able to increase population growth indirectly by making the settlement safer, more prosperous, better supplied, and more attractive.

Possible player-influenced growth sources:

- clearing raiders from roads,
- securing food and supply routes,
- improving housing,
- improving health and sanitation,
- protecting nearby farms,
- accepting refugees,
- rescuing captives,
- integrating nearby settlements,
- creating jobs through mines/workshops,
- building roads,
- creating religious/cultural appeal,
- maintaining peace and safety,
- receiving divine or magical fertility effects,
- stabilizing neighboring regions.

Population growth should not be free. More people provide more labor and manpower potential, but also create more supply demand, more housing pressure, more vulnerability during famine or siege, and more lives to protect.

#### What v0.1 Does Not Need Yet

The first prototype does not need:

- full birth/death demographics,
- families,
- age cohorts,
- social classes,
- detailed professions,
- taxes,
- wages,
- housing simulation,
- morale,
- unrest,
- happiness,
- disease,
- seasonal fertility,
- food variety,
- markets,
- migration preference modeling,
- cultural assimilation,
- long-term inheritance.

Those systems can come later. For v0.1, population only needs to prove one core idea:

> People are the source of work and war. Losing them matters.

#### Long-Term Resource Design Debt

The prototype should explicitly defer deeper economic questions rather than pretending they are solved.

Long-term AXIOM likely needs answers for:

- population classes and labor specialization,
- natural growth versus migration,
- food and seasonal supply,
- farms and settlement food production,
- rations and military supply lines,
- roads, depots, warehouses, and regional storage,
- housing and carrying capacity,
- refugees and migration pressure,
- trade goods versus strategic materials,
- money versus barter versus stored wealth,
- equipment stockpiles and replacement losses,
- civilian demand for valuable materials,
- military maintenance costs,
- scarcity, hoarding, spoilage, and transport capacity,
- specialist wages, loyalty, poaching, and capture,
- taxation, tribute, trade agreements, and emergency requisition,
- and how local economies react when supply chains are cut.

These are not required for the first prototype, but the v0.1 model should avoid design choices that make them impossible later.

#### Final Design Principle

> Population is the source of labor, manpower, settlement resilience, and long-term survival. Supplies are the fuel that lets people work and fight away from home. Materials are local opportunities that must be physically claimed and moved. Equipment turns people into effective workers or soldiers. The economy succeeds if every useful action consumes real capacity somewhere, and if repeated losses make the player feel that they are endangering Hearthmere's future, not merely losing replaceable units.


### 13.27 Prototype Implementation Phasing

The full v0.1 scenario includes raiders, abstract combat, camp assault, casualty results, and scenario endings. However, those systems add significant complexity: AI behavior, visibility, combat resolution, casualty handling, squad state, and victory/defeat logic. The first playable implementation should therefore be phased.

Design principle:

> Build the discovery, population, labor, supplies, and logistics loop first. Add raiders only after the non-combat economy and material loop can stand on their own.

#### Phase 1 — Non-Combat Discovery / Economy / Logistics Prototype

The first playable slice should omit active raiders and combat. It should prove that the player can inspect the local world, assign scarce labor, survey prospects, find a useful material, establish extraction, move supplies and ore physically, test the material, and commit the first batch to weapons, armor, or research.

Phase 1 should include:

- Hearthmere population, available workforce, and labor teams
- supplies as a produced, stocked, consumed, and shipped physical good
- several prospect sites, including at least one false/low-value lead
- surveying and deposit confirmation
- claim deposit and establish mine
- mine supply consumption
- local mine stockpile and Hearthmere stockpile
- shipment routes and caravans
- fast route versus slow route timing
- forge/research/material testing actions
- first material Codex reveal sequence
- weapons-vs-armor-vs-research commitment
- basic project timing and hourly simulation

Phase 1 should not include:

- active raider AI
- combat resolution
- casualty states beyond unused placeholders
- camp assault
- settlement sack defeat
- hidden raider movement
- scenario victory based on clearing Blackbanner Camp

A Phase 1 success condition can be simple:

> The player confirms a valuable prospect, establishes the mine, keeps it supplied long enough to produce ore, transports ore to Hearthmere, discovers at least one material property, and completes either a weapons or armor project.

This does not prove the whole AXIOM scenario, but it proves the foundation. If this loop is not interesting, raiders will only add noise. If this loop works, raiders can then test whether that foundation holds under pressure.

#### Phase 2 — Passive / Simulated Threat Layer

Before full raider AI, the prototype can add a light pressure placeholder. This layer should not require combat. It can represent danger as route risk, delayed shipments, lost time, or a simple warning state while still avoiding full AI.

Possible Phase 2 additions:

- route danger indicators based on known dangerous areas
- chance of shipment delay on risky routes
- optional supply/ore loss event without detailed combat
- visible but non-interactive raider flavor icons near Blackbanner Camp
- warnings that certain routes will eventually need escorts once combat is implemented

This phase is optional. It exists only if the logistics loop feels too sterile without any threat. It should not become a permanent substitute for physical raider actors.

#### Phase 3 — Raider Map Entities and Vision

Once Phase 1 works, add raiders as physical map entities without immediately requiring every combat context.

Phase 3 should include:

- visible or last-seen raider parties
- raiders moving through the region-node map
- scouts/watch positions revealing raiders earlier
- raiders shadowing routes or gathering near exposed value
- notifications based on sightings rather than abstract threat meters

The main test is whether raiders feel like actors in the world instead of event popups.

#### Phase 4 — First Combat Context: Caravan Ambush

The first active combat implementation should be the caravan ambush resolver. It touches the most systems at once: shipments, cargo value, supplies, speed, escorts, raiders, equipment, field discovery, and losses.

Phase 4 should include:

- raiders intercepting a shipment
- escort participation if assigned
- cargo delivered, delayed, partially stolen, or lost
- squad casualties as returned ready, wounded/recovering, or killed
- equipment influence from weapons/armor coverage
- fire/thermal field discovery if the encounter includes fire exposure

The caravan ambush resolver should be implemented before mine raids, settlement attacks, or camp assaults because it is the cleanest test of AXIOM's logistics-combat connection.

#### Phase 5 — Mine Raid, Settlement Defense, and Camp Assault

After caravan ambushes work, add the remaining combat contexts:

- mine raids for exposed stockpiles
- settlement defense as the main defeat condition
- raider camp assault as the main military victory condition
- scenario end summaries

These complete the original v0.1 pressure arc, but they should not block the first playable implementation.

#### Phase 6 — Tactical Battle Prototype

The FFT-style tactical battle layer remains a later experiment. It should not be required for the first discovery/logistics prototype. When eventually added, it should replace or deepen abstract combat contexts without undermining the population, logistics, material, and squad systems already defined.

#### Phasing Summary

| Phase | Purpose | Raider/Combat Scope |
|---|---|---|
| **Phase 1** | Prove discovery + economy + logistics | None |
| **Phase 2** | Add light route pressure if needed | Passive risk only |
| **Phase 3** | Add raiders as visible world actors | Movement/vision, no full combat required |
| **Phase 4** | Add first combat context | Caravan ambush only |
| **Phase 5** | Complete local threat arc | Mine raid, settlement defense, camp assault |
| **Phase 6** | Explore long-term battle fantasy | Tactical battles |

Design rule:

> Raiders are essential to the full prototype, but they do not need to exist in the first implementation slice. The first implementation should prove that a strange material, a limited population, labor teams, supplies, local stockpiles, and physical shipments already create meaningful decisions.


### 13.28 Phase 1 Implementation Definition

Phase 1 is the first buildable implementation target. It should be a non-combat prototype that proves AXIOM's discovery, population, labor, supply, and logistics foundation before adding raiders, combat, AI, or scenario defeat states.

Phase 1 should answer one question:

> Is discovering a strange material, committing scarce people and supplies to exploit it, physically moving it through the world, and turning it into a first strategic output already interesting before enemies are added?

If the answer is no, raiders and combat will only mask the problem. If the answer is yes, raiders can later test the system under pressure.

#### Phase 1 Success Condition

The smallest successful Phase 1 loop is:

> The player confirms a valuable prospect, establishes a mine, keeps it supplied long enough to produce ore, transports ore to Hearthmere, discovers at least one material property, and completes one meaningful output: weapons, armor/shields, or a clearly useful non-combat material application if implemented.

This is not a full scenario victory. It is a vertical-slice completion condition. The prototype can show a simple summary once this condition is met.

Example summary:

```text
Phase 1 Complete
Hearthmere confirmed the Redglass deposit, established extraction, delivered ore to the settlement, learned one key property, and completed its first meaningful Redglass output.
```

#### Included Systems

Phase 1 should include only the systems required to complete the non-combat loop.

Required systems:

1. **Strategic map shell**
   - Hearthmere
   - several nearby regions
   - visible prospect sites
   - route connections
   - basic map selection panel

2. **Population and labor**
   - total population
   - available workforce
   - labor teams
   - labor assignment to projects
   - reassignment friction if labor is pulled away

3. **Supplies**
   - Hearthmere supply stockpile
   - supply production through assigned labor
   - mine supply consumption
   - local supply storage at the mine
   - supply shipments from Hearthmere to the mine

4. **Prospecting**
   - multiple prospect sites
   - survey action
   - at least one false, mundane, low-yield, or exhausted lead
   - one true strange-material deposit

5. **Mine and local stockpiles**
   - claim deposit
   - establish mine
   - active/paused mine state
   - ore production only while supplied and staffed
   - local mine ore stockpile
   - Hearthmere ore stockpile after delivery

6. **Caravans / shipments**
   - create shipment
   - origin, destination, cargo, route, ETA
   - physical movement over time
   - delivery into local stockpile
   - fast route versus slow route timing

7. **Material Codex**
   - initial unknown entry
   - survey/discovery entry
   - practical test entry
   - at least one revealed property
   - explicit v0.1 property language when discovered

8. **Forge / research choice**
   - basic material test or academy analysis
   - forge weapons
   - forge armor/shields
   - optional non-combat material application if cheap to implement
   - project timing
   - completed equipment or utility output

9. **Hourly time model**
   - pause/play/speed controls
   - hourly ticks
   - project progress
   - shipment progress
   - supply production/consumption
   - notifications for completion and delivery

#### Excluded Systems

Phase 1 should not include systems that create combat or AI complexity.

Excluded from Phase 1:

- active raider AI
- raider map entities
- combat resolution
- squad casualties
- wounded recovery
- camp assault
- settlement sack/defeat
- militia/watch squad creation unless needed as a placeholder UI test
- stealth/concealment
- diplomacy
- trade economy
- money/coin spending
- divine systems
- Legacy Empire behavior
- tactical battles

These systems remain part of the broader v0.1 or post-prototype plan, but they should not block Phase 1.

#### Phase 1 Player Flow

Phase 1 should play roughly like this:

1. The player starts at Hearthmere with basic local knowledge.
2. The player inspects several prospect sites.
3. The player assigns a labor team to survey one prospect.
4. The survey reveals either a bad lead or a useful material deposit.
5. The player claims the useful deposit.
6. The player assigns labor and supplies to establish the mine.
7. The mine begins consuming supplies and producing ore into a local stockpile.
8. The player sends supplies to the mine if needed.
9. The player sends ore from the mine to Hearthmere by caravan.
10. The player chooses whether to test/research the ore or forge immediately.
11. The Codex reveals at least one useful property.
12. The player completes one meaningful output: weapons, armor/shields, or a simple non-combat material application if implemented.
13. The prototype displays a Phase 1 completion summary.

This loop should be playable without any enemy pressure. The pressure comes from scarce labor, scarce supplies, travel time, local stockpiles, and uncertainty about which prospect and material use are worthwhile.

#### Phase 1 Decision Pressure

Without raiders, Phase 1 still needs meaningful choices. Those choices should come from limited capacity.

The player should not be able to do all of the following comfortably at once:

- survey every prospect,
- produce maximum supplies,
- establish the mine immediately,
- run research,
- run the forge,
- ship supplies,
- ship ore,
- and complete both weapons and armor.

The Phase 1 economy should force tradeoffs like:

- survey more prospects or rush the first promising lead,
- produce supplies or spend the starting stockpile,
- establish the mine faster or keep labor available for testing/forging,
- send a small ore shipment early or wait for a larger load,
- test the material before forging or commit immediately,
- craft weapons, armor, or a simple utility/value-oriented output first.

Design target:

> Phase 1 should feel like a constrained production/logistics puzzle with mystery, not a combat scenario with the enemies removed.

#### Phase 1 UI Minimum

The first implementation only needs these panels and actions:

| Surface | Required Actions |
|---|---|
| **Hearthmere** | inspect population, labor teams, supplies, stockpiles, active projects |
| **Prospect site** | inspect, survey, show survey result |
| **Deposit / mine** | claim, establish mine, assign labor, view supplies/ore, pause/resume |
| **Route** | inspect travel time, select route for shipment |
| **Shipment** | create, inspect cargo/ETA, deliver on arrival |
| **Academy / research** | run basic test or analysis |
| **Forge** | craft weapons, craft armor/shields |
| **Material Codex** | show observed, tested, and revealed properties |
| **Notification log** | survey complete, mine established, supplies arrived, ore arrived, test complete, project complete |

The map object should remain the source of truth. Notifications should jump back to the relevant prospect, mine, shipment, project, or Codex entry.

#### Phase 1 Data Objects

A minimal implementation can be built from these objects:

```text
Settlement
- population
- availableWorkforce
- laborTeamsAvailable
- suppliesStockpile
- oreStockpilesByMaterial
- activeProjects

ProspectSite
- region
- visibleDescription
- surveyState
- surveyOutcome
- revealedDepositId

Deposit / Mine
- materialId
- owner
- state
- assignedLaborTeams
- suppliesStockpile
- oreStockpile
- productionRate
- supplyConsumptionRate

Material
- name
- variantRoll
- observedTraits
- revealedProperties
- codexEntries

Project
- type: survey / claim / establishMine / research / forgeWeapons / forgeArmor
- assignedLaborTeams
- requiredInputs
- progressHours
- requiredHours
- output

Shipment
- origin
- destination
- cargoType
- cargoAmount
- route
- progress
- eta
- state

Route
- start
- end
- travelHours
- routeType
```

These can be expanded later with raider entities, squads, combat contexts, specialists, money, trade, and diplomacy.

#### Phase 1 Tuning Targets

All numbers remain placeholders. The first build should tune for decision feel, not realism.

Initial targets:

- Hearthmere has enough labor/supplies to do several things, but not everything.
- Surveying one prospect should be quick enough to keep the opening moving.
- Confirming the true deposit should take enough time that choosing which lead to survey matters.
- Establishing the mine should feel like a real commitment.
- The mine should require supplies soon enough that supply logistics matter.
- Ore should be produced quickly enough to reach the first equipment decision in one short test session.
- Testing/research should compete with immediate forging, not obviously dominate it.
- The first equipment project should complete fast enough to close the Phase 1 loop.

Phase 1 should probably target a short test session of roughly 10–20 real minutes once basic UI is functional.

#### Phase 1 Exit Criteria

Phase 1 is ready to move into Phase 2 or Phase 3 when the following are true:

- The player understands that prospects are uncertain.
- The player understands that labor comes from finite population capacity.
- The player understands that supplies are physical goods that must be produced and moved.
- The player understands that ore belongs to a place until shipped.
- The player has to make at least one meaningful prioritization tradeoff.
- The player sees the Material Codex update based on testing or research.
- The player completes a weapons, armor/shield, or simple utility/value-oriented project from discovered ore.
- The loop is at least mildly interesting without enemies.

If the loop feels automatic, obvious, or empty, fix the discovery/economy/logistics loop before adding raiders.

Design principle:

> Phase 1 succeeds when the player can feel AXIOM's core idea without a single battle: the world contains uncertain opportunities, exploiting them costs real capacity, and knowledge turns physical resources into strategy.


### 13.29 Phase 1 Non-Combat Material Payoffs

Because Phase 1 intentionally excludes raiders and combat, material discovery needs at least a few non-combat payoffs. The full v0.1 scenario still uses weapons, armor, and combat-facing equipment because raiders arrive soon after Phase 1, but the first implementation slice should not rely entirely on future battles to make material properties feel relevant.

Phase 1 should therefore treat materials as useful in three ways:

1. **Preparation for future conflict**
   Weapons and armor remain valid outputs. Even if they are not tested in combat yet, completing the first equipment project proves that ore can become military readiness.

2. **Logistics and production behavior**
   Material properties can affect shipment burden, forging time, project difficulty, storage value, or how much labor/supply pressure the material creates.

3. **Value and opportunity**
   A material may matter because it is desirable, rare, beautiful, symbolically important, or worth protecting, even before anyone swings a weapon made from it.

For Phase 1, the most useful non-combat material properties are:

| Property | Phase 1 Use |
|---|---|
| **Workability** | Changes forge/research time, rushed-project risk, or whether a project needs extra labor hours. |
| **Weight / Burden** | Changes shipment size, caravan travel time, storage pressure, or how much ore can move in one load. |
| **Value / Appeal** | Makes the material worth securing even if it is not immediately militarily useful. Later this can feed trade, theft, diplomacy, tribute, religious offerings, or prestige. |
| **Thermal Response** | Can be discovered through testing even before combat; later it becomes useful in fire-exposure conflicts. |
| **Weapon Suitability** | Tells the player whether a future weapon project is promising, mediocre, or risky. |
| **Armor / Shield Suitability** | Tells the player whether a future defensive project is promising, mediocre, or risky. |

The Phase 1 Codex can be blunt about these properties once discovered. Example entries:

```text
Workability: Difficult. Forge projects using this material take longer.
Weight / Burden: High. Shipments carry less ore per caravan load.
Value / Appeal: High. Even non-military actors would likely want samples.
Weapon Suitability: Low. Not recommended for the first weapons project.
Armor / Shield Suitability: High. Strong candidate for defensive equipment.
Thermal Response: Unusual. Further testing recommended.
```

This keeps the first build from feeling like a combat system with the enemies removed. The player can still discover that a material is hard to ship, expensive to work, valuable to outsiders, better for one equipment form than another, or worth delaying for research.

Phase 1 does not need full trade, diplomacy, theft, morale, prestige, religion, or combat. It only needs the player to understand that a material can be strategically important for reasons other than immediate damage and defense.

Design principle:

> Phase 1 should prove that material knowledge matters before combat. Combat-facing properties remain important because combat is the next validation layer, but the first slice should also let materials affect logistics, production, value, and future planning.


### 13.30 Phase 1 Domain/Data Model

The Phase 1 data model should be treated as a **domain model**, not a final database schema. Its purpose is to identify the durable objects AXIOM believes exist in the world and the relationships between them, while keeping Phase 1 implementation fields simple.

Design principle:

> Model things that exist in the world, not abstract menu shortcuts. Prototype fields may be temporary, but the object relationships should point toward the full game.

Each domain object should be understood in three layers:

1. **Durable domain concept** — likely to survive into the full game.
2. **Phase 1 implementation fields** — the smallest fields needed for the no-raider discovery/economy/logistics slice.
3. **Future expansion notes** — places where the object can grow later without being redesigned from scratch.

The first implementation should avoid hard-coding shortcuts that contradict core AXIOM principles, especially the rules that there is no global inventory, population is the source of labor and manpower, supplies are physical goods, and discovery is progressive.

#### Core Phase 1 Objects

##### Game State / Scenario State

The scenario state tracks global runtime information and references all active world objects.

Phase 1 fields:

```text
current_hour
current_day
time_of_day
simulation_speed
regions[]
routes[]
settlements[]
materials[]
projects[]
shipments[]
event_log[]
completion_state
```

Future expansion:

- weather
- seasons
- deity moods
- diplomacy state
- Legacy Empire arcs
- AI faction plans
- world laws
- multiple settlements and faction-wide summaries

##### Region

A region is a meaningful place on the strategic map. Regions contain prospects, deposits, settlements, facilities, stockpiles, visible actors, and route endpoints.

Phase 1 fields:

```text
id
name
terrain_type
owner_or_influence
known_to_player
connected_route_ids[]
prospect_site_ids[]
deposit_ids[]
settlement_ids[]
notes
```

Future expansion:

- security and contested control
- terrain traits
- divine influence
- magical anomalies
- local weather
- regional fertility
- hidden actors
- neutral/hostile settlements
- population movement
- long-term development

##### Route

A route connects regions and is the physical path used by shipments, squads, raiders, and later armies.

Phase 1 fields:

```text
id
name
from_region_id
to_region_id
travel_time_hours_loaded_caravan
travel_time_hours_light_party
route_type
known_to_player
```

Future expansion:

- road quality
- capacity
- seasonal passability
- patrol coverage
- ambush risk from visible actors
- scouting/vision state
- chokepoints
- fortifications
- tolls
- enemy blockade
- route-specific supply throughput

##### Settlement

A settlement is a population center, production center, stockpile location, and home base. Hearthmere is the only required Phase 1 settlement.

Phase 1 fields:

```text
id
name
region_id
population_pool_id
stockpile_id
facility_ids[]
active_project_ids[]
settlement_defense_value
```

Future expansion:

- housing
- food production
- local economy
- unrest
- tax/tribute
- specialists
- social groups
- migration attraction
- health/disease
- religious/cultural identity
- multiple local districts

##### Population Pool

The population pool is the root source of labor, manpower, recovery, and settlement resilience.

Phase 1 fields:

```text
id
settlement_id
total_population
available_workforce
labor_team_size
available_labor_teams
assigned_labor_teams
mobilized_manpower
recovering_population
recent_losses
```

Future expansion:

- age cohorts
- households
- professions
- skill continuity
- social class
- migration pressure
- refugees
- captives
- natural growth
- disease
- morale/unrest
- cultural assimilation

##### Labor Assignment

A labor assignment represents one or more labor teams committed to an active task. It is the prototype bridge between population and projects.

Phase 1 fields:

```text
id
settlement_id
labor_teams_committed
assignment_type
linked_project_id
linked_facility_id
start_hour
continuity_hours
status
```

Phase 1 assignment types:

```text
survey
claim_deposit
establish_mine
operate_mine
produce_supplies
forge_project
research_project
```

Future expansion:

- profession fit
- skill accumulation
- efficiency from continuity
- reassignment friction
- worker safety
- wages
- labor unrest
- specialist supervision
- overwork penalties

##### Stockpile

A stockpile is a local container for physical goods. There should be no global inventory. Hearthmere, mines, caravans, and later depots can all have stockpiles.

Phase 1 fields:

```text
id
location_type
location_id
capacity_by_good_type
items[]
```

Each stockpile item can be represented as:

```text
good_type
material_id optional
quantity
```

Example Phase 1 goods:

```text
supplies
redglass_ore
mundane_ore
basic_equipment optional
redglass_equipment optional
```

Future expansion:

- spoilage
- storage buildings
- warehouses
- depots
- pack animals
- refined vs raw goods
- item quality
- ownership disputes
- theft
- capture
- trade reservations

##### Supply Good

Supplies can be represented as one stockpile good in Phase 1, but the domain model should treat them as physical operating goods, not a stamina meter.

Phase 1 fields:

```text
quantity in local stockpile
production_per_day if labor assigned
consumption_per_hour by active mine/project/shipment if needed
```

Future expansion:

- food
- tools
- fodder
- medicine
- ammunition
- lamp oil
- pack animals
- seasonal shortages
- drought/famine
- military rations
- civilian consumption

##### Prospect Site

A prospect site is a visible opportunity whose usefulness is unknown until surveyed.

Phase 1 fields:

```text
id
region_id
name
surface_clue_text
survey_state
survey_progress_hours
survey_required_hours
outcome_type
revealed_deposit_id optional
```

Phase 1 survey states:

```text
visible_unsurveyed
surveying
survey_complete
ignored
```

Phase 1 outcome types:

```text
false_or_exhausted
mundane_low_yield
valuable_strange_deposit
```

Future expansion:

- hidden prospect quality
- faction-specific observation bonuses
- local rumors
- geology/biome rules
- contested claims
- rival surveyors
- sacred/taboo sites
- dangerous survey events

##### Material Profile

A material profile defines the generated behavior of a material in this world. Redglass in one world should not necessarily behave like Redglass in another.

Phase 1 fields:

```text
id
provisional_name
material_family
hidden_variant_key
weapon_suitability
armor_shield_suitability
thermal_response
weight_burden
workability
value_appeal
simple_magical_modifier optional
```

Prototype values can be explicit and simple:

```text
low / medium / high
+attack modifier
+defense modifier
fire_damage_modifier
shipment_burden_modifier
forge_time_modifier
trade_value_rating
```

Future expansion:

- physical sliders
- magical tags
- divine resonance
- alloy behavior
- per-form equipment derivation
- procedural material naming
- faction interpretation differences
- wildlife/crop/material cross-effects

##### Material Discovery State / Codex Entry

The Codex tracks what the player knows about a material. It should be separate from the hidden material profile.

Phase 1 fields:

```text
id
material_id
known_name
source_deposit_ids[]
known_observations[]
revealed_properties[]
active_research_project_ids[]
field_notes[]
discovery_progress_by_property optional
```

Each revealed property can be represented as:

```text
property_key
revealed_value
reveal_method
reveal_hour
player_facing_text
```

Reveal methods:

```text
observation
survey
practical_test
academy_analysis
field_use future
```

Future expansion:

- uncertainty ranges
- competing theories
- faction knowledge modifiers
- false assumptions
- specialist notes
- experiment history
- alloy notes
- shared/stolen knowledge
- AI faction knowledge states

##### Deposit / Mine

A deposit is a confirmed resource site. A mine is the active extraction operation built on that deposit.

Phase 1 fields:

```text
id
region_id
material_id
deposit_state
claim_state
mine_state
local_stockpile_id
assigned_labor_teams
supply_consumption_per_day
ore_output_per_day
connected_route_ids[]
```

States:

```text
confirmed_unclaimed
claimed
mine_establishing
active
paused
out_of_supplies
```

Future expansion:

- deposit size
- depth
- depletion
- mine safety
- specialist operators
- processing requirements
- worker deaths
- sabotage
- capture
- multiple extraction methods
- environmental damage

##### Facility

Facilities are controllable infrastructure objects inside a settlement or region.

Phase 1 facilities:

```text
forge
academy_or_research_space
stockpile
mine_camp
```

Phase 1 fields:

```text
id
facility_type
location_type
location_id
status
active_project_ids[]
assigned_labor_teams
```

Future expansion:

- facility levels
- specialist slots
- maintenance
- construction chains
- capture/damage
- power/fuel requirements
- processing subtypes
- temples
- depots
- roads/forts/watchposts

##### Project

Projects represent time-based commitments that consume labor, supplies, materials, or facility access and produce an output.

Phase 1 fields:

```text
id
project_type
location_type
location_id
status
progress_hours
required_hours
assigned_labor_teams
input_requirements
reserved_inputs
output_result
started_hour
completed_hour optional
```

Phase 1 project types:

```text
survey_prospect
claim_deposit
establish_mine
produce_supplies
practical_material_test
academy_analysis
forge_weapons
forge_armor_or_shields
utility_or_value_output optional
```

Project statuses:

```text
available
active
paused_lacking_labor
paused_lacking_supplies
paused_lacking_material
complete
cancelled
```

Future expansion:

- construction queues
- specialist influence
- quality levels
- rush penalties
- interrupted work efficiency loss
- multi-stage projects
- parallel workers
- risk events
- hidden experimental outcomes

##### Shipment / Caravan

A shipment is a moving stockpile transfer. In Phase 1 it may be a simple caravan entity without guards or raider interaction.

Phase 1 fields:

```text
id
origin_stockpile_id
destination_stockpile_id
route_id or route_path_ids[]
cargo_items[]
status
progress_hours
travel_required_hours
current_region_or_route_id
```

Statuses:

```text
loading
moving
arrived
cancelled
```

Future expansion:

- escort assignment
- guards
- ambush state
- cargo visibility
- stolen cargo
- route changes at safe nodes
- caravan speed by load
- pack animals
- convoy size
- trade contracts

##### Equipment Batch / Forge Output

An equipment batch is a produced output stored locally. It may later equip squads, settlement defenses, caravans, or facilities.

Phase 1 fields:

```text
id
location_stockpile_id
equipment_type
material_id
quantity_or_coverage
known_modifiers[]
unknown_modifiers_possible
source_project_id
```

Phase 1 equipment types:

```text
weapons
armor_or_shields
utility_output optional
```

Future expansion:

- item quality
- form-specific gear
- per-squad equipment coverage
- repairs
- durability
- specialist maker history
- alloy components
- magical attunement
- captured/lost equipment

##### Event Log / Notification

Events summarize changes and link back to the world object that caused them.

Phase 1 fields:

```text
id
hour
category
summary_text
linked_object_type
linked_object_id
importance
read_state
```

Phase 1 categories:

```text
survey_complete
deposit_confirmed
project_complete
shipment_departed
shipment_arrived
stockpile_shortage
codex_updated
scenario_complete
```

Future expansion:

- sightings
- raids
- diplomacy
- divine omens
- Legacy Empire signals
- rumors
- character events
- combat reports

#### Deferred But Reserved Objects

The Phase 1 data model should leave room for these objects without requiring them immediately:

| Object | Why Reserved |
|---|---|
| **Squad** | Needed for raiders/combat phases; later connects manpower, supplies, equipment, movement, and assignments. |
| **Assignment** | Needed for guard, escort, scout, patrol, watchpost, and recovery jobs. Labor assignments exist in Phase 1; squad assignments come later. |
| **Raider Party / Actor** | Needed for visible world pressure after Phase 1. Should use the same region/route/movement concepts as caravans and squads. |
| **Combat Report** | Needed once caravan ambushes and casualties exist. Should connect to population, equipment, cargo, and Codex field discovery. |
| **Trade Offer / Market Actor** | Needed once Value / Appeal becomes more than a planning signal. |
| **Specialist** | Needed once named workers, researchers, smiths, captains, and spies add identity and efficiency. |

Do not build full versions of these in Phase 1 unless needed, but avoid data structures that make them hard to add later.

#### Key Relationships

The Phase 1 object graph should follow these relationships:

```text
Region contains Prospect Sites, Deposits, Settlements, Facilities, and local actors.
Route connects Regions.
Settlement owns a Population Pool, Facilities, Projects, and a local Stockpile.
Population Pool creates Labor Teams.
Labor Assignments feed Projects and Facilities.
Stockpiles contain physical goods at a specific location.
Deposits produce material into a local Stockpile when supplied and staffed.
Shipments move goods from one Stockpile to another along Routes.
Material Profile contains hidden truth.
Material Discovery State / Codex Entry contains player-known truth.
Projects transform time + labor + supplies + materials into discoveries, facilities, shipments, or equipment outputs.
Equipment Batches are stored locally until assigned or used by future squad systems.
Events point back to the object that changed.
```

This relationship model matters more than exact Phase 1 numbers. If these relationships are correct, the prototype can grow into the full design without replacing its foundation.

#### Phase 1 State Transitions

Minimum useful transitions:

```text
Prospect Site:
visible_unsurveyed → surveying → survey_complete → false/mundane/valuable

Deposit / Mine:
confirmed_unclaimed → claimed → mine_establishing → active → paused/out_of_supplies

Project:
available → active → paused/complete/cancelled

Shipment:
loading → moving → arrived

Material Codex:
unknown → observed → tested → analyzed

Stockpile Item:
at source → in shipment → at destination
```

Future phases can add transitions such as ambushed, stolen, damaged, captured, exhausted, contested, routed, wounded, recovered, or traded.

#### Implementation Guidance

For Phase 1, prefer a small set of plain data objects over a complex simulation architecture. The important part is to keep object boundaries honest:

- Do not store ore as a global player number.
- Do not let projects consume materials that are not physically present at the project location.
- Do not let the mine operate without labor and supplies.
- Do not let the Codex reveal hidden material truth until an observation, test, analysis, or field event reveals it.
- Do not make labor reassignment instant and consequence-free if the project is supposed to feel physical.
- Do not add money until there is something concrete to spend it on.

A simple JSON-style implementation is acceptable for the first build. The goal is not database elegance; the goal is to preserve AXIOM's core world logic.

Design principle:

> Phase 1 data should be simple, but not fake. If a resource, person, project, or material matters, it should belong to a place, consume time, and connect to the player's knowledge of the world.


### 13.31 Phase 1 Implementation Checklist

This checklist translates the Phase 1 design into a build order. It is not a final production plan for the full game. It is the smallest implementation path for proving the no-raider discovery/economy/logistics loop before adding hostile actors, combat, or tactical battles.

Phase 1 should answer one question:

> Can discovery, labor scarcity, supplies, local stockpiles, physical shipments, material testing, and first outputs feel interesting before combat pressure exists?

The checklist is ordered so each step produces a visible testable result. Avoid building later systems until the current slice can be clicked through in-game.

#### Phase 1 Build Rule

Build vertical behavior before breadth.

The first implementation should prefer one working prospect, one working settlement, one working stockpile, one working shipment, and one working material reveal over broad but disconnected menus.

Do not implement raiders, combat, squads, stealth, diplomacy, trade, specialists, tactical battles, or advanced procedural generation in Phase 1 unless they are needed as stubs for later data compatibility.

#### Milestone 0 — Project Skeleton and Scenario Load

Goal:

> The game can load a single handcrafted Phase 1 scenario and display the main map screen.

Tasks:

- Create the Phase 1 scenario file or seed data.
- Create the seven named regions even if only a subset is active in Phase 1:
  - Hearthmere
  - Redglass Foothills
  - Ashen Pass
  - Old Pine Road
  - Westmere Farms
  - Blackbanner Camp
  - The Silent Border
- Create route connections between regions.
- Mark raider/combat regions as inactive placeholders for Phase 1.
- Create a basic real-time clock with pause/play.
- Add the hourly tick, even if few systems use it at first.
- Add a basic event log.

Definition of done:

- The scenario loads without player setup.
- The player can see Hearthmere, connected regions, and route lines.
- Time can pause and advance.
- The event log can display at least one scenario-start message.

#### Milestone 1 — Static Map Inspection

Goal:

> The player can click physical world objects and understand that decisions happen through places, routes, and opportunities.

Tasks:

- Implement selectable regions.
- Implement the region detail panel.
- Implement route inspection.
- Implement Hearthmere as the main settlement object.
- Implement visible prospect markers.
- Add placeholder icons for settlement, prospect, route, stockpile, and shipment.
- Add notification click-through to map objects.

Minimum inspectable objects:

- Hearthmere
- Redglass Foothills
- at least three prospect sites
- fast route through Ashen Pass
- slow route through Old Pine Road / Westmere Farms

Definition of done:

- Clicking each map object opens a useful panel.
- The player can tell where Hearthmere is, where prospects are, and which routes connect them.
- No actions need to work yet beyond inspection.

#### Milestone 2 — Hearthmere Economy Foundation

Goal:

> Hearthmere has people, labor, supplies, and local storage, and those values update over time.

Tasks:

- Implement Hearthmere population fields:
  - total population
  - available workforce
  - labor teams
  - mobilized manpower placeholder, even if squads are not active yet
  - recovering placeholder
  - recent losses placeholder
- Implement local Hearthmere stockpile.
- Implement supplies as a physical stockpiled good.
- Implement supply production as a labor assignment.
- Implement labor team assignment UI.
- Implement labor assignment friction in a lightweight way:
  - assigning a labor team starts or supports a project,
  - removing labor pauses or slows the project,
  - no instant free optimization across all tasks.

Suggested first tuning values remain placeholders:

```text
Hearthmere
- Population: 240
- Available Workforce: 120
- Labor Team Size: 20 workers
- Available Labor Teams: 6
- Supplies: 60 / 100
- Supply Production: +12 per day with one labor team assigned
- Mobile Field Squads: 0
- Basic Weapons Stockpile: 0
- Basic Armor/Shields Stockpile: 0
- Coin: omitted
```

Phase 1 does not need soldiers, wounds, or deaths yet, but the population structure should not block them later.

Definition of done:

- The player can inspect Hearthmere's population/labor/supply state.
- Assigning labor to supply production increases Hearthmere supplies over time.
- The UI communicates that labor teams are scarce.

#### Milestone 3 — Project System

Goal:

> Time-based actions exist and can consume labor, supplies, materials, and location access.

Tasks:

- Implement a generic project object.
- Implement project states:
  - available
  - active
  - paused
  - complete
  - cancelled, optional
- Implement project requirements:
  - location
  - labor teams
  - supplies, optional per project
  - material input, optional per project
  - time remaining
- Implement hourly project progress.
- Implement project completion notification.
- Implement project pause when requirements are missing.

Initial project types:

- survey prospect
- claim deposit
- establish mine
- produce supplies
- practical material test
- academy analysis
- forge output

Definition of done:

- At least one test project can be started, paused by removing labor, resumed, completed, and logged.
- Completed projects can create or modify world objects.

#### Milestone 4 — Prospecting Loop

Goal:

> The player can evaluate uncertain opportunities and discover that not every prospect is valuable.

Tasks:

- Implement at least three prospect sites.
- Give each prospect a visible clue.
- Implement survey project on prospect sites.
- Implement survey result outcomes:
  - true strange material deposit
  - mundane/low-yield material
  - false/exhausted lead
- Add prospect state transitions:
  - visible lead
  - surveying
  - surveyed barren / poor / useful
  - claimable deposit
- Add event log entries for survey completion.

Minimum Phase 1 prospects:

1. One true Redglass-like deposit.
2. One mundane or low-yield site.
3. One false or exhausted site.

The true deposit can be fixed for the first tutorial prototype, then randomized later.

Definition of done:

- The player can survey multiple prospects.
- At least one prospect confirms a usable strange material.
- At least one prospect teaches that visible leads are not guaranteed value.

#### Milestone 5 — Material Profile and First Codex Entry

Goal:

> Confirming a deposit creates a material identity and a Codex entry that starts mostly unknown.

Tasks:

- Implement material profile data.
- Implement material discovery state.
- Implement Material Codex panel.
- Create at least two prototype material variant rolls:
  - defensive / fire-hardened
  - offensive / keen-edge
- Optionally stub later rolls:
  - high-value / low-military
  - volatile / research-favored
- Ensure early clues are ambiguous and do not reveal the solution.
- Add initial Codex entry when material is confirmed.

Initial Codex entry should be simple:

```text
Material: Redglass Ore
Source: Redglass Foothills
Observed: Red, glassy mineral seam
Known Uses: Unknown
Risks: Unknown
```

Definition of done:

- Surveying the true prospect creates a material profile.
- The Codex shows the material as known but untested.
- The player cannot infer the material's best use from the first description alone.

#### Milestone 6 — Deposit Claim and Mine Setup

Goal:

> A confirmed deposit can become an operating extraction site through a time/labor commitment.

Tasks:

- Implement claim deposit project.
- Implement establish mine project.
- Create mine object after establishment.
- Add mine panel.
- Add mine local stockpile.
- Add mine supply storage.
- Implement mine active/paused state.
- Implement mine consuming supplies while active.
- Implement mine producing ore into its local stockpile.

Phase 1 should include supply consumption now, even without raiders, because supplies are the first non-combat pressure source.

Definition of done:

- The player can turn a confirmed deposit into a mine.
- The mine produces ore only if active and supplied.
- Ore appears at the mine, not globally.
- If mine supplies run out, production pauses or slows.

#### Milestone 7 — Local Stockpiles and No Global Inventory

Goal:

> Resources exist in places.

Tasks:

- Implement stockpile object by location.
- Support at least these stockpiled goods:
  - Supplies
  - Redglass Ore or equivalent strange material
  - optional mundane material placeholder
  - finished equipment batch, if needed
- Implement stockpile caps.
- Show Hearthmere stockpile separately from mine stockpile.
- Prevent Hearthmere projects from using ore that is still at the mine.

Definition of done:

- The player can see different supply/ore amounts at Hearthmere and the mine.
- Forge/research projects at Hearthmere cannot use material until it arrives there.
- Mine stockpile filling creates pressure to ship, pause, or expand later.

#### Milestone 8 — Shipment and Route Loop

Goal:

> Goods move physically by shipment/caravan between local stockpiles.

Tasks:

- Implement shipment object.
- Implement create shipment action from one stockpile to another.
- Implement route selection.
- Implement shipment travel time.
- Implement shipment state:
  - loading
  - moving
  - arrived
  - cancelled/recalled, optional for Phase 1
- Implement supply shipment from Hearthmere to mine.
- Implement ore shipment from mine to Hearthmere.
- Show moving shipment on map.
- Add arrival notification.

Minimum routes:

- Fast route through Ashen Pass.
- Slow route through Old Pine Road / Westmere Farms.

No ambushes are required in Phase 1, but the route choice should already show different travel times.

Definition of done:

- The player can ship supplies to the mine.
- The player can ship ore to Hearthmere.
- The shipment is visible while traveling.
- Arrival transfers cargo from origin to destination stockpile.
- Route choice changes travel time.

#### Milestone 9 — Practical Testing and Academy Analysis

Goal:

> The player can spend time and labor to reveal material properties.

Tasks:

- Implement practical test project at Hearthmere.
- Implement academy analysis project at Hearthmere.
- Require delivered sample/material at Hearthmere.
- Reveal one or more material properties on completion.
- Update Codex entry.
- Add event log notification.

Phase 1 can reveal properties explicitly for clarity.

Example reveal categories:

- Weapon Suitability
- Armor / Shield Suitability
- Workability
- Weight / Burden
- Thermal Response
- Value / Appeal

Definition of done:

- The player can test a delivered material sample.
- The Codex changes after testing.
- The revealed property supports at least one decision: forge, research more, ship more, or deprioritize.

#### Milestone 10 — Forge Output / Meaningful Material Use

Goal:

> The player can turn discovered material into a meaningful output.

Tasks:

- Implement forge project.
- Require delivered ore at Hearthmere.
- Require labor and time.
- Support at least two output choices:
  - weapons
  - armor/shields
- Optionally support one non-combat Phase 1 output:
  - trade/value sample
  - reinforced tools
  - heat-resistant plating test
  - high-value prepared ingot
- Connect known material properties to output expectations.
- Create an equipment batch or output object on completion.
- Update Codex with output notes.

Definition of done:

- The player can choose weapons or armor/shields from the first material batch.
- The output reflects revealed or hidden material properties at least in text/summary.
- The player can complete Phase 1 by making a meaningful material output.

#### Milestone 11 — Phase 1 Completion Summary

Goal:

> The prototype has an ending even without enemies.

Tasks:

- Define Phase 1 completion trigger:
  - confirmed material deposit,
  - operating supplied mine,
  - ore transported to Hearthmere,
  - at least one property discovered,
  - at least one meaningful output completed.
- Create a summary screen.
- Summarize key player decisions:
  - prospects surveyed,
  - false leads found,
  - labor bottlenecks encountered,
  - supply shipments made,
  - material properties discovered,
  - output chosen.
- Add a clear message that Phase 2/3 will add external pressure.

Definition of done:

- The player can finish a no-raider prototype run.
- The summary communicates what was discovered and what strategy it might support.
- The player can imagine how raiders/combat would make the same loop more tense.

#### Milestone 12 — Basic Save/Reload or Scenario Reset

Goal:

> The prototype can be tested repeatedly without rebuilding state manually.

Tasks:

- Add reset scenario action.
- Add basic save/load if feasible.
- At minimum, support quick restart with a new or fixed material variant.
- Log material variant internally for debugging.

Definition of done:

- A tester can replay Phase 1 multiple times.
- Material variant behavior can be inspected/debugged.
- Restarting does not require developer intervention.

#### Milestone 13 — Debug and Tuning Tools

Goal:

> The designer can tune the economy without guessing.

Tasks:

- Add debug display or export for:
  - current hour/day,
  - active projects,
  - labor assignment state,
  - stockpiles by location,
  - shipment state,
  - material profile roll,
  - known vs hidden material properties.
- Add speed controls that make test runs fast.
- Add simple event log filtering if needed.

Definition of done:

- It is easy to see why something is or is not progressing.
- Labor/supply/logistics problems can be diagnosed during testing.
- Material discovery outcomes can be verified.

#### Phase 1 Minimum Object Checklist

By the end of Phase 1, the implementation should have these objects working at least minimally:

| Object | Required in Phase 1? | Notes |
|---|---:|---|
| Game State / Scenario State | Yes | Time, pause, scenario status, event log |
| Region | Yes | Clickable map locations |
| Route | Yes | Travel paths and travel time |
| Settlement | Yes | Hearthmere only is enough |
| Population Pool | Yes | Total population, workforce, labor teams |
| Labor Assignment | Yes | Scarce project capacity |
| Stockpile | Yes | Local supplies and material storage |
| Supplies | Yes | Produced, stored, shipped, consumed by mine |
| Prospect Site | Yes | Multiple leads, some bad |
| Material Profile | Yes | Hidden generated/rolled material behavior |
| Codex Entry | Yes | Progressive knowledge state |
| Deposit / Mine | Yes | Claim, establish, supply, produce |
| Facility | Light | Forge/academy can be Hearthmere panel actions |
| Project | Yes | Time-based survey, mine setup, tests, forge |
| Shipment / Caravan | Yes | Visible movement of goods |
| Equipment Batch / Output | Yes | At least weapons/armor or equivalent output |
| Squad | No | Reserved for Phase 3/4 unless needed as stub |
| Raider | No | Reserved for Phase 3 |
| Combat Report | No | Reserved for Phase 4 |
| Specialist | No | Reserved unless one simple helper is cheap |
| Trade Actor | No | Reserved for future/value systems |

#### Phase 1 Testing Questions

Once Phase 1 is playable, test it against these questions:

1. Does the player understand that resources exist in places rather than a global inventory?
2. Does prospecting feel like discovery rather than clicking the obvious mine?
3. Does labor scarcity create real opportunity cost?
4. Do supplies matter before enemies exist?
5. Does shipping ore physically across the map feel meaningful?
6. Does the Codex update make the player want to change plans?
7. Does a material with poor combat value but high value/appeal still feel worth caring about?
8. Is the first finished output satisfying enough to imply future strategy?
9. Does the player ever wait for something meaningful to finish, arrive, or reveal?
10. Is the no-combat loop mildly interesting on its own, or does it need raider pressure immediately?

#### Phase 1 Cut Line

If scope becomes too large, cut in this order:

1. Save/load beyond scenario reset.
2. Non-combat material outputs beyond weapons/armor.
3. Multiple material variant rolls beyond two.
4. Slow alternate route, if one route is enough for first test.
5. Academy analysis, if practical testing alone proves the loop.
6. Stockpile caps, if local stockpiles still exist.
7. Labor continuity bonuses, but keep labor team scarcity.

Do not cut:

- local stockpiles,
- supplies as physical goods,
- prospect uncertainty,
- time-based projects,
- shipment movement,
- material Codex updates,
- at least one meaningful material output.

Those are the core of Phase 1.

#### Phase 1 Completion Definition

Phase 1 is complete when a tester can start from Hearthmere and, without developer assistance:

1. inspect the local map,
2. survey at least two prospect sites,
3. confirm one valuable material deposit,
4. claim and establish a mine,
5. keep the mine supplied long enough to produce ore,
6. ship ore to Hearthmere,
7. run at least one material test or analysis,
8. see the Codex update,
9. complete one meaningful forge/material output,
10. reach a summary screen explaining what happened.

The first playable implementation should stop there. Raiders, squads, ambushes, combat, and victory/defeat pressure should be added only after this loop exists and has been tested.



### 13.32 Phase 1 UX Flow

This section translates the Phase 1 implementation checklist into a player-facing flow. It defines what the player sees, clicks, reads, and decides during the first no-raider prototype slice.

Phase 1 has no combat pressure. Its UX must therefore make scarcity, time, physical logistics, and discovery clear enough that the prototype still feels like AXIOM rather than a static resource menu.

UX principle:

> The player should understand the loop by clicking through the world: inspect the local situation, survey uncertain prospects, claim a deposit, support the mine, move ore physically, test or forge the material, and see the Codex update.

The player should not need to read a long tutorial before acting. Each screen should expose the next plausible decisions through the selected world object.

#### UX Step 0 — Scenario Start

The prototype opens on the strategic map with time paused or running at the slowest speed.

Visible at start:

- Hearthmere, the player's capital settlement.
- Nearby known regions and roads.
- Several prospect markers.
- The fast Ashen Pass route and the slower Old Pine Road route.
- Placeholder or inactive distant regions such as Blackbanner Camp and The Silent Border, if shown for context.
- A top bar with time controls, current day/hour, and a compact Hearthmere summary.
- An event log with one opening message.

Opening message example:

```text
Hearthmere begins with limited labor, a modest supply stockpile, and several local prospect leads. Choose what to investigate first.
```

The first screen should communicate three things immediately:

1. The player already knows the local area; this is not a blank-map reveal game.
2. There are multiple opportunities, not one obvious correct click.
3. Labor and supplies are limited enough that the player cannot do everything at once.

#### UX Step 1 — Inspect Hearthmere

The player clicks Hearthmere.

The Hearthmere panel should show:

- population summary,
- available workforce,
- available labor teams,
- local supplies,
- local stockpiles,
- active projects,
- inactive/available facilities,
- current labor assignments,
- and local completion goal hints.

Minimum visible fields:

```text
Hearthmere
Population: 240
Available Workforce: 120
Labor Teams Available: 6
Supplies: 60 / 100
Active Projects: None
Local Redglass Ore: 0
Mobile Squads: 0
```

Minimum actions visible from Hearthmere:

- Assign Labor
- Produce Supplies
- Open Projects
- Open Forge
- Open Academy / Testing
- Open Stockpile

In Phase 1, squad and combat buttons can be hidden, disabled, or marked as later if they are not implemented yet.

The UX goal is for the player to think:

> Hearthmere has capacity, but not enough to pursue every opportunity at once.

#### UX Step 2 — Inspect Prospect Sites

The player clicks visible prospect markers.

Each prospect panel should show:

- prospect name or placeholder description,
- region/location,
- visible surface clue,
- survey status,
- required labor/time to survey,
- and possible uncertainty.

Example:

```text
Prospect: Unusual Red Seam
Location: Redglass Foothills
Visible Clue: A thin red mineral line is visible in exposed foothill stone. Local workers do not recognize it.
Status: Unsurveyed
Action: Begin Survey
Requires: 1 Labor Team
Estimated Time: 18 hours
```

Other prospects may show clues such as exposed grey stone, old dig marks, strange soil, or brittle black rock. The UI should not reveal which prospect is valuable before survey.

The UX goal is for the player to think:

> I have leads, not answers.

#### UX Step 3 — Begin a Survey Project

The player chooses a prospect and clicks **Begin Survey**.

The project should appear in at least two places:

- the prospect panel,
- and Hearthmere's active project list or project sidebar.

Project display example:

```text
Survey: Unusual Red Seam
Location: Redglass Foothills
Labor: 1 Team assigned
Progress: 0 / 18 hours
Status: Active
```

The player should see that a labor team is now committed. Hearthmere's available labor count should decrease or the assigned labor list should clearly show the commitment.

If the player removes the labor team, the project should pause rather than vanish.

Pause state example:

```text
Survey paused: no labor team assigned.
Progress preserved: 7 / 18 hours.
```

The UX goal is for the player to understand:

> Projects are time commitments, and labor cannot be everywhere.

#### UX Step 4 — Advance Time and Watch Projects Progress

The player unpauses or increases speed.

During this phase, the UI should emphasize progress without requiring micromanagement.

Useful feedback:

- project progress bar or hour count,
- active project list,
- event log entry when halfway/complete if useful,
- labor assignment summary,
- top-bar time progression,
- supply production changes if labor is assigned to supplies.

Phase 1 should avoid flooding the player with alerts. The important notifications are:

- survey complete,
- supplies produced,
- project paused due to missing requirements,
- material discovered,
- shipment departed/arrived,
- test/research/forge complete.

The UX goal is for time to feel meaningful, not noisy.

#### UX Step 5 — Survey Result

When the survey completes, the player receives a notification that jumps to the prospect.

Possible result types:

1. Useful strange deposit.
2. Mundane or low-yield material.
3. False/exhausted lead.

Useful deposit example:

```text
Survey Complete: Strange Ore Confirmed
Surveyors confirmed a workable deposit of unfamiliar red, glassy ore. Its practical uses are unknown.
```

False lead example:

```text
Survey Complete: Exhausted Seam
The visible surface mark looked promising, but the usable material has long since weathered away.
```

The true material result should create or update:

- a deposit object on the map,
- a Material Profile,
- and an initial Material Codex entry.

Initial Codex entry example:

```text
Redglass Ore
Source: Redglass Foothills
Observed: Red, glassy mineral seam
Known Uses: Unknown
Risks: Unknown
```

The UX goal is for the player to learn:

> Surveying converts uncertain opportunity into actionable knowledge, but not every lead pays off.

#### UX Step 6 — Claim the Deposit

The player selects the confirmed deposit and clicks **Claim Deposit**.

Claim panel should show:

- required labor,
- estimated time,
- what claiming changes,
- and what remains unavailable until the mine is established.

Example:

```text
Claim Redglass Deposit
Requires: 1 Labor Team
Time: 8 hours
Result: Marks the deposit as controlled by Hearthmere and unlocks basic extraction setup.
```

After completion, the deposit state changes from **Confirmed** to **Claimed**.

The UX goal is for the player to understand:

> Discovery alone does not produce resources. I have to claim and develop the site.

#### UX Step 7 — Establish the Mine

The claimed deposit panel now offers **Establish Mine**.

Mine setup should clearly display that remote extraction will require both labor and supplies.

Example:

```text
Establish Redglass Mine
Requires: 2 Labor Teams
Requires: 10 Supplies delivered or allocated
Time: 30 hours
Result: Creates an active mine with local supply storage and local ore stockpile.
```

For Phase 1, if supply delivery to the mine is not yet separated from setup, the setup project can consume supplies from Hearthmere directly. Once shipments are implemented, supplies should physically move.

When complete, the deposit becomes a mine object.

The UX goal is for the player to understand:

> A mine is not a passive income icon. It is a remote work site that needs people and supplies.

#### UX Step 8 — Mine Panel and Local Stockpile

The Redglass Mine panel should show:

- mine state,
- assigned labor,
- local supplies,
- local ore stockpile,
- production rate,
- connected routes,
- and shipment actions.

Example:

```text
Redglass Mine
Status: Active
Labor: 1 Team assigned
Mine Supplies: 12 / 20
Ore Stockpile: 0 / 30
Production: +4 Ore every 12 hours while supplied
```

The panel should make local storage obvious. Ore at the mine should not appear in Hearthmere's stockpile.

The UX goal is for the player to internalize:

> I do not own usable Redglass at Hearthmere yet. It is sitting at the mine.

#### UX Step 9 — Supply the Mine

The player must understand that supplies are physical goods.

If the mine has low supplies, the mine panel should show a clear warning:

```text
Mine supplies low. Extraction will pause when supplies reach 0.
```

The player creates a supply shipment from Hearthmere to the mine.

Shipment creation panel should show:

- cargo type,
- amount,
- origin,
- destination,
- route options,
- travel time,
- and local stockpile changes after departure.

Example:

```text
Create Shipment
Cargo: Supplies
Amount: 10
Origin: Hearthmere
Destination: Redglass Mine
Route: Ashen Pass, 12 hours / Old Pine Road, 24 hours
```

For Phase 1, no raiders are active, but route choice should still matter through travel time. The UI should preserve the route-choice habit before danger exists.

The UX goal is for the player to think:

> Supplies have to travel before remote work can continue.

#### UX Step 10 — Ship Ore to Hearthmere

Once ore accumulates at the mine, the player creates an ore shipment.

Shipment panel example:

```text
Create Shipment
Cargo: Redglass Ore
Amount: 8
Origin: Redglass Mine
Destination: Hearthmere
Route Options:
- Ashen Pass: faster
- Old Pine Road: slower
```

The caravan should appear on the map as a moving icon.

Clickable caravan panel should show:

- cargo,
- current route,
- current location/progress,
- origin,
- destination,
- estimated arrival,
- and status.

Example:

```text
Caravan: Redglass Ore Shipment
Cargo: 8 Redglass Ore
Route: Redglass Foothills → Ashen Pass → Hearthmere
ETA: 9 hours
Status: Moving
```

When the caravan arrives, the mine stockpile decreases and Hearthmere's Redglass stockpile increases.

The UX goal is for the player to see:

> The resource became useful only after it physically arrived.

#### UX Step 11 — Test, Analyze, or Forge

Once Redglass is physically present at Hearthmere, the player can use the Forge or Academy/Testing panel.

Available actions depend on what is implemented:

- Run Practical Test
- Begin Academy Analysis
- Forge Basic Material Output
- Forge Weapons
- Forge Armor/Shields

For Phase 1, if combat is not active, the output does not have to be battle-ready. It can be a prototype equipment batch, a reinforced shield batch, a trade sample, or a treated ingot. The key is that the material's discovered properties affect the output or future decision.

Testing action example:

```text
Run Practical Test: Redglass Ore
Requires: 2 Redglass Ore
Requires: 1 Labor Team
Time: 18 hours
Expected Result: Reveals one practical property.
```

Forge action example:

```text
Forge Redglass Shield Batch
Requires: 6 Redglass Ore
Requires: 1 Labor Team
Time: 30 hours
Known Risk: Material behavior incomplete.
```

The UX goal is for the player to face the central Phase 1 question:

> Do I spend scarce material now, or spend time learning more first?

#### UX Step 12 — Codex Update

When testing or analysis completes, the Material Codex should update clearly.

Phase 1 Codex language can be explicit.

Example discovered entry:

```text
Redglass Ore
New Finding: Workability — Difficult
Effect: Forge projects using Redglass take longer unless improved by later tools or specialists.
```

Another example:

```text
New Finding: Weight / Burden — High
Effect: Redglass shipments are heavy; caravans carry fewer units per trip.
```

Another example:

```text
New Finding: Armor / Shield Suitability — High
Effect: Redglass is promising for defensive equipment once combat systems are active.
```

The Codex should also link back to:

- source deposit,
- current stockpile locations,
- active research/testing project,
- and available forge outputs.

The UX goal is for the player to understand:

> My knowledge changed, so my strategic options changed.

#### UX Step 13 — Complete First Meaningful Output

Phase 1 ends when the player completes one meaningful material application. The output can be combat-facing or non-combat-facing, depending on implementation scope.

Valid Phase 1 outputs include:

- Redglass weapon batch,
- Redglass armor/shield batch,
- treated Redglass ingot,
- high-value trade sample,
- research-confirmed material profile,
- or a first equipment/project output whose usefulness depends on a discovered property.

The output completion panel should show:

- what was produced,
- where it is stored,
- what was consumed,
- what is now known,
- and what remains unknown.

Example:

```text
Output Complete: Redglass Shield Batch
Stored At: Hearthmere
Consumed: 6 Redglass Ore, 1 Labor Team for 30 hours
Known Relevant Property: Armor / Shield Suitability — High
Unknown: Thermal Response, Magical Behavior
```

The UX goal is for the player to feel:

> I turned an uncertain local discovery into a concrete strategic asset.

#### UX Step 14 — Phase 1 Completion Summary

The first no-raider slice should end with a short summary screen rather than simply stopping.

Summary should answer:

- Which prospects were surveyed?
- Which material was discovered?
- What did the player learn about it?
- How much labor/time/supplies were spent?
- Where did the material physically move?
- What output was completed?
- What remains unknown for future phases?

Example summary:

```text
Phase 1 Complete: First Material Application

Hearthmere surveyed 2 prospect sites and confirmed Redglass Ore in the foothills.
Workers claimed the deposit, established a supplied mine, moved ore by caravan, and completed a first Redglass output at Hearthmere.

Known Redglass Properties:
- Workability: Difficult
- Armor / Shield Suitability: High

Still Unknown:
- Thermal Response
- Magical Behavior
- Field Performance

Next Phase Preview:
Once raiders and combat are enabled, this supply chain and equipment decision will be tested under pressure.
```

The UX goal is to reinforce the prototype thesis:

> Even without combat, discovery created a chain of decisions.

#### Phase 1 UX Anti-Goals

Phase 1 should avoid these player experiences:

- The player sees a global Redglass number that ignores location.
- The player can run every project at once without meaningful labor pressure.
- The player surveys every prospect before any decision matters.
- The player receives exact material truth from the first clue.
- The player clicks one button and instantly turns ore into equipment.
- The player has no reason to care where supplies or ore physically are.
- The player finishes without seeing the Codex update.
- The player reaches the end without understanding why future raider pressure will matter.

#### Phase 1 UX Definition of Done

The Phase 1 UX is successful when a new player can answer these questions without developer explanation:

- Where is Hearthmere?
- How many labor teams do I have available?
- Which prospect am I surveying?
- What did the survey discover?
- Where is the ore right now?
- Does the mine have supplies?
- Which route is the shipment taking?
- What does the Codex know about the material?
- What output did I create?
- What remains unknown?

Design principle:

> The player should learn AXIOM's logic by following physical things through the world: people, supplies, ore, projects, shipments, and knowledge.



### 13.33 Phase 1 Playtest Criteria and Test Scenarios

Phase 1 intentionally omits raiders and combat. Its purpose is to test whether AXIOM's discovery, population, labor, supply, local-stockpile, and logistics loop is understandable and at least mildly compelling before external threats are added.

The Phase 1 playtest should not ask whether the game is complete. It should ask whether the foundation is worth pressurizing with raiders, combat, trade, rivals, specialists, and tactical battles.

Core playtest question:

> Is the discovery/logistics/economy loop interesting enough that adding raiders feels like the obvious next pressure layer, rather than a rescue for a weak core loop?

#### Phase 1 Acceptance Goals

A Phase 1 build is successful if a tester can understand and feel the following without developer explanation:

1. **Resources are local.**  
   Supplies, ore, and finished outputs exist in specific places. The player should understand that ore at the mine is not usable at Hearthmere until a shipment physically delivers it.

2. **Population and labor are real constraints.**  
   The player should understand that labor teams come from Hearthmere's available workforce and that assigning labor to one task means another task waits.

3. **Supplies are physical operating fuel.**  
   The player should understand that the mine does not merely require a setup cost; it needs supplies to keep working, and those supplies must be produced, stored, and shipped.

4. **Prospecting creates uncertainty.**  
   The player should not feel like they are choosing from a menu of guaranteed resource nodes. Some leads should be poor, false, mundane, or less immediately useful.

5. **Material knowledge changes decisions.**  
   The player should see the Codex move from unknown to partially known, and the discovered property should influence whether they test, research, forge, store, ship, or prioritize the material.

6. **Projects make time matter.**  
   Surveying, claiming, mine setup, testing, research, shipments, and forging should consume time in a way that creates sequencing decisions, not just progress-bar waiting.

7. **The player can imagine where pressure will attack the system.**  
   By the end of Phase 1, the player should naturally understand why raiders, rival prospectors, drought, trade demand, or route disruption would matter.

#### Pass / Fail Summary

Phase 1 passes if the player can say something like:

> I found an uncertain opportunity, committed scarce labor and supplies to exploit it, moved physical goods through the world, learned something useful, and made a strategic choice based on that knowledge. I can see how raiders or rivals would make this tense.

Phase 1 fails if the player says something like:

> I clicked through progress bars until a resource number went up.

or:

> I do not understand why the mine, supplies, route, shipment, or Codex needed to exist separately.

#### Required Test Scenarios

The first playtest pass should include several simple scenarios rather than only the ideal happy path. These can be scripted, manually tested, or supported by debug controls.

##### 1. Happy Path Test

The player surveys a prospect, confirms the valuable material, establishes the mine, supplies it, ships ore to Hearthmere, runs a test or research project, completes a meaningful material output, and reaches the Phase 1 summary.

Purpose:

> Confirm the full no-raider loop works from start to finish.

Pass indicators:

- Player understands the next step at each stage.
- Ore is visibly local to the mine before shipment.
- Shipment movement is understandable.
- Codex updates are noticeable.
- The final output feels connected to the discovered material.

##### 2. Wrong Prospect First Test

The player surveys a poor, mundane, false, or exhausted prospect before finding the true valuable material.

Purpose:

> Confirm that prospecting feels like discovery and not just a scripted first-click reward.

Pass indicators:

- The failed/poor prospect is clear but not frustrating.
- The player understands they can continue surveying other leads.
- The time/labor spent feels like an opportunity cost.

Fail indicators:

- The player feels punished for guessing wrong.
- The player cannot tell why the prospect was not useful.
- The player assumes all prospects are fake or random noise.

##### 3. Supply Bottleneck Test

The player establishes the mine but fails to deliver enough supplies, causing the mine to slow, pause, or become unable to produce the next ore batch.

Purpose:

> Confirm that supplies are understood as physical operating goods.

Pass indicators:

- The player can tell where supplies are located.
- The player understands why the mine slowed or paused.
- The player knows how to create or adjust a supply shipment.

Fail indicators:

- The player thinks the mine is bugged.
- The player cannot tell whether the issue is labor, supplies, stockpile capacity, route delay, or project state.

##### 4. Labor Overcommitment Test

The player attempts to survey, produce supplies, establish the mine, test/research, and forge at the same time, then runs out of available labor teams or forces some projects to wait.

Purpose:

> Confirm that labor scarcity creates prioritization instead of confusion.

Pass indicators:

- The player understands which projects are using labor teams.
- The player understands how to pause, delay, or reassign labor.
- The player feels forced to choose priorities.

Fail indicators:

- The player believes labor disappeared.
- The player thinks the UI is blocking actions arbitrarily.
- The optimal behavior is always to assign one labor team to everything equally.

##### 5. Material Surprise Test

The player initially expects one use for the material, but testing or research reveals a different property: poor weapon suitability, high value/appeal, difficult workability, high burden, useful thermal response, or better armor/shield suitability.

Purpose:

> Confirm that discovery changes strategy before combat exists.

Pass indicators:

- The player changes or reconsiders their plan after the Codex update.
- The discovered property has a visible implication for Phase 1 output, logistics, value, or future combat preparation.
- The player understands that another world's version of the material could behave differently.

Fail indicators:

- The revealed property does not affect any available decision.
- The player feels the material was solved from the first clue.
- The player ignores the Codex because it does not matter yet.

##### 6. Local Inventory Test

The player has supplies at Hearthmere, ore at the mine, and a shipment in transit. The player attempts to use ore or supplies from the wrong location.

Purpose:

> Confirm that no-global-inventory logic is legible.

Pass indicators:

- The UI clearly shows why the resource is unavailable at the selected location.
- The player can identify where the resource is and how to move it.
- The player understands shipment arrival as a meaningful state change.

Fail indicators:

- The player expects resources to be globally usable.
- The player cannot find where the missing resource is stored.
- The UI appears to contradict itself by showing a resource in one panel but not another.

#### Quantitative Tuning Questions

Phase 1 playtests should gather rough answers to these questions. Exact values will change, but the direction matters.

- How many labor teams does Hearthmere need for the player to feel constrained but not paralyzed?
- How many prospect sites can exist before surveying feels like busywork?
- How long can survey/mine/setup/research/forge projects take before the player feels they are only waiting?
- How slow can shipments be before physical logistics feel annoying rather than meaningful?
- How quickly should the player see the first Codex update?
- Does the mine consume supplies fast enough to matter, but not so fast that it becomes tedious?
- Does the Phase 1 output feel meaningful without combat?
- Does the player understand what will become dangerous once raiders are added?

#### Qualitative Playtest Questions

After a Phase 1 test, ask the player:

1. What did you think your first priority should be, and why?
2. Did prospecting feel like discovery or like busywork?
3. Did you understand where your supplies and ore physically were?
4. Did labor assignment feel like a real tradeoff?
5. Did the Codex update change what you wanted to do?
6. Were you ever confused about why a project could not progress?
7. Did the final material output feel earned?
8. Where did you expect future danger or pressure to come from?
9. What did you want to do next after Phase 1 ended?

The most important answer is question 9. If the player naturally says they want to defend the route, protect the mine, test the equipment in battle, trade the material, find more deposits, or see what rivals do, Phase 1 is working.

#### Phase 1 Acceptance Criteria

Phase 1 should not advance to raider implementation until these criteria are met:

- The player can complete the loop without developer guidance.
- The player understands local stockpiles and shipments.
- The player understands that supplies are consumed by remote activity.
- The player understands that labor teams are scarce and assigned.
- The player sees at least one Codex update before completion.
- The player completes at least one meaningful material output.
- The player can explain why adding raiders, rivals, trade, or weather would increase pressure.
- The player does not describe the experience primarily as waiting for unrelated timers.

#### Phase 1 Failure Modes to Watch

Common failure modes:

- **Progress-bar soup:** too many projects are running with too little visible world feedback.
- **Fake logistics:** shipments feel like timers rather than moving physical goods.
- **Global inventory confusion:** resources appear to exist everywhere and nowhere.
- **Over-scoped economy:** too many resource types before the basic loop is fun.
- **Under-scoped economy:** supplies/labor are so simple that no real decision exists.
- **Codex irrelevance:** discovered properties do not change any available choice.
- **No future pull:** the player finishes Phase 1 but does not care what happens next.

#### Phase 1 Exit Decision

After playtesting, decide one of three paths:

1. **Loop is understandable but too safe:** add Phase 2 passive route pressure or visible raider scouting.
2. **Loop is confusing:** improve UI, local stockpile clarity, project feedback, and Codex messaging before adding threats.
3. **Loop is boring even when understood:** revise material payoffs, labor scarcity, supply throughput, or shipment friction before adding AI/combat.

Do not add raiders merely to hide a weak discovery/logistics loop. Add raiders when the player already understands what they are threatening.

Design principle:

> Phase 1 succeeds when the player wants pressure added because the system already has obvious weak points worth defending.



### 13.34 Phase 1 Technical Architecture / Build Handoff

Phase 1 should be built as a small but durable vertical slice. The goal is not to create the final engine architecture, but to avoid building a disposable prototype that cannot grow into the full AXIOM design.

The first implementation should organize code and data around the same durable objects defined in the Phase 1 domain model: regions, settlements, population, labor, supplies, stockpiles, prospects, deposits, projects, materials, Codex entries, routes, and shipments.

Architecture principle:

> Build Phase 1 around durable world objects and simple systems. Prototype fields can be temporary, but the object relationships should point toward the full game.

#### Phase 1 Architecture Goals

The technical architecture should support five immediate needs:

1. **A small playable scenario**
   The game can load a handcrafted scenario containing Hearthmere, nearby regions, routes, prospect sites, material variants, and starting population/supply values.

2. **A reliable hourly simulation loop**
   Projects, supply production, supply consumption, shipment movement, survey progress, mine output, and Codex updates advance through a single understandable time system.

3. **Local resources, not global inventory**
   Supplies, ore, materials, and finished outputs live in stockpiles attached to settlements, mines, caravans, or facilities.

4. **Player-facing decisions through world objects**
   The UI selects regions, settlements, prospects, projects, mines, stockpiles, routes, shipments, and Codex entries. Actions should be contextual to the selected object.

5. **Clean extension points for later phases**
   Raiders, squads, combat, trade, specialists, stealth, tactical battles, richer materials, and diplomacy should plug into the same world/time/logistics architecture later.

#### Recommended High-Level Modules

Phase 1 can be implemented with the following modules or system boundaries. These do not need to be separate packages immediately, but their responsibilities should stay distinct.

| Module | Responsibility |
|---|---|
| **Scenario Loader** | Creates the initial handcrafted Phase 1 world state. |
| **Game State Store** | Owns current time, map state, objects, projects, stockpiles, events, and selected object. |
| **Time / Simulation System** | Advances the world by hourly ticks and coordinates system update order. |
| **Map / Region System** | Stores regions, routes, map objects, ownership, known state, and selection. |
| **Settlement / Economy System** | Tracks Hearthmere population, workforce, labor teams, supply production, and settlement stockpiles. |
| **Labor Assignment System** | Assigns labor teams to projects and sustained activities. Handles assignment friction. |
| **Stockpile / Inventory System** | Tracks local goods at specific places. Prevents global inventory shortcuts. |
| **Project System** | Runs time-based work: survey, claim, mine setup, research, testing, forging. |
| **Prospecting / Deposit System** | Manages prospect sites, survey results, deposit confirmation, and mine creation. |
| **Material / Discovery System** | Stores hidden material profiles, revealed properties, discovery states, and Codex entries. |
| **Logistics / Shipment System** | Creates caravans, moves goods along routes, transfers cargo on arrival. |
| **Event / Notification System** | Records important changes and links notifications to world objects. |
| **UI Panel System** | Shows contextual panels for selected objects and exposes available actions. |
| **Debug / Tuning Tools** | Speeds testing: advance time, complete project, add supplies, reveal material, reset scenario. |

#### Core Game State

The game state should be explicit and serializable. Even if save/load is not implemented immediately, the structure should make it possible later.

Minimum Phase 1 state:

```text
GameState
- currentHour
- currentDay
- timeSpeed
- isPaused
- scenarioStatus
- selectedObjectId
- regions[]
- routes[]
- settlements[]
- prospects[]
- deposits[]
- facilities[]
- stockpiles[]
- projects[]
- shipments[]
- materialProfiles[]
- materialDiscoveryStates[]
- eventLog[]
```

Phase 1 should avoid storing derived values as primary truth when possible. For example, if Hearthmere's available labor teams derive from available workforce and mobilized manpower, the UI can display the derived value, but the underlying state should make clear where it comes from.

Prototype rule:

> Store durable facts. Compute summaries.

#### Scenario Loader

The first build should use a handcrafted scenario file or data object. Procedural generation can wait.

Minimum scenario contents:

```text
Scenario
- map regions
- route graph
- Hearthmere settlement
- starting population/economy values
- initial supply stockpile
- initial prospect sites
- material variant table
- chosen or randomized material roll
- Phase 1 completion objective
```

The Scenario Loader should make it easy to reset and replay with a different material variant or prospect result. This is important because the whole premise depends on different worlds producing different strategic implications.

Recommended debug scenario toggles:

- fixed true Redglass prospect,
- randomized true prospect,
- defensive/fire material variant,
- offensive/weapon material variant,
- high-value/low-military material variant,
- volatile/research-favored material variant,
- generous labor/supply tuning,
- tight labor/supply tuning.

#### Time / Simulation System

The Time System should be the spine of the prototype.

Minimum responsibilities:

- pause/play,
- speed control,
- hourly tick,
- day/night value,
- daily production checks,
- project progress,
- shipment movement,
- notification dispatch.

Recommended Phase 1 tick order:

```text
1. Check scheduled production
2. Apply sustained consumption
3. Move shipments
4. Advance projects
5. Apply project completions
6. Apply discovery/Codex updates
7. Create notifications
8. Check Phase 1 completion condition
```

This should remain compatible with the fuller hourly order already defined for later raiders and combat. Phase 1 does not need actor decisions, visibility/detection checks, or conflict resolution yet, but the time system should leave room for them.

Implementation note:

> Do not let each system run its own independent timer logic. Projects, production, and shipments should all advance from the same simulation tick so future raiders and combat can reason about the world consistently.

#### Map / Region System

The map system should support selection, inspection, routes, and object lookup. It does not need pathfinding beyond the handcrafted route graph.

Minimum objects:

```text
Region
- id
- name
- description
- knownState
- regionType
- connectedRouteIds[]
- containedObjectIds[]
```

```text
Route
- id
- name
- fromRegionId
- toRegionId
- travelHoursByEntityType
- routeType
- knownState
```

For Phase 1, route danger can exist as flavor or future-facing metadata. It does not need active raider logic.

Minimum map interactions:

- click region,
- click route,
- click prospect,
- click mine/deposit,
- click shipment,
- jump to object from notification.

#### Settlement / Economy System

Hearthmere should be the initial economy anchor.

Minimum settlement fields:

```text
Settlement
- id
- name
- regionId
- populationPoolId
- stockpileId
- facilityIds[]
- laborAssignments[]
- baseSettlementDefense
```

The settlement system should not become a city-builder yet. It only needs to answer:

- How many people are available?
- How many labor teams can be assigned?
- What supplies are stored here?
- What projects are running here?
- What materials have arrived here?
- What actions are available from Hearthmere?

#### Population and Labor System

The population system should follow the v0.36/v0.37 direction: population is the root of labor and military manpower, but the player interacts mainly with labor teams for Phase 1.

Minimum fields:

```text
PopulationPool
- totalPopulation
- availableWorkforce
- laborTeamSize
- mobilizedManpower
- woundedRecovering
- deadOrMissing
```

```text
LaborAssignment
- id
- settlementId
- assignedTeamCount
- targetObjectId
- assignmentType
- startedAtHour
- continuityHours
```

For Phase 1, mobilized manpower may stay at zero if no squads exist yet. The model should still include it because Phase 2/3 will need it.

Minimum labor rules:

- labor teams are assigned in chunks,
- assigning a team reduces free labor capacity,
- removing a team pauses or slows its project,
- projects should clearly show missing labor if reassignment breaks progress,
- optional continuity bonuses can be deferred but the data model may reserve a field.

#### Stockpile / Local Inventory System

This is one of the most important Phase 1 systems. It must prevent the prototype from drifting into global inventory.

Minimum stockpile fields:

```text
Stockpile
- id
- locationObjectId
- capacityByGoodType
- quantitiesByGoodType
```

Good types for Phase 1:

```text
GoodType
- Supplies
- RedglassOre or StrangeOre
- MaterialSample
- BasicEquipmentOutput, optional
- RedglassWeapons or RedglassArmor, optional if forge output is represented as stockpile goods
```

Rules:

- a settlement stockpile is not the same as a mine stockpile,
- a mine can only consume supplies stored at the mine or delivered by shipment,
- Hearthmere cannot use ore until a shipment delivers it,
- a project can only consume goods from an allowed local stockpile,
- shipments transfer goods between stockpiles only when they arrive.

Implementation warning:

> Do not create a convenient global resource object for Redglass or supplies. If a summary is needed in the UI, compute it from local stockpiles.

#### Project System

The Project System should be generic. Surveying, claiming, mine setup, testing, analysis, and forging should all be time-based projects rather than unique one-off timers.

Minimum project fields:

```text
Project
- id
- projectType
- locationObjectId
- targetObjectId
- requiredLaborTeams
- assignedLaborTeams
- requiredGoods
- consumedGoods
- totalWorkHours
- completedWorkHours
- status
- resultPayload
```

Project types for Phase 1:

- Survey Prospect,
- Claim Deposit,
- Establish Mine,
- Basic Material Test,
- Academy Analysis,
- Forge Weapons,
- Forge Armor,
- Optional: Produce Supplies if supply production is project-based rather than a daily assignment.

Recommended status values:

```text
NotStarted
Active
PausedMissingLabor
PausedMissingSupplies
PausedMissingMaterial
Complete
Cancelled
```

Project completion should trigger world changes:

- survey reveals prospect result,
- claim creates controlled deposit state,
- establish mine creates active mine/facility and mine stockpile,
- test/analysis updates Codex,
- forge creates equipment output or material application summary.

#### Prospecting / Deposit / Mine System

Prospects should be uncertain opportunities. Deposits and mines are confirmed world objects.

Minimum prospect fields:

```text
ProspectSite
- id
- regionId
- visibleName
- visibleClueText
- surveyStatus
- resultType
- linkedMaterialProfileId, optional
- createsDepositOnSuccess
```

Result types:

```text
FalseLead
MundaneLowYield
ValuableMaterialDeposit
```

Minimum deposit/mine fields:

```text
Deposit
- id
- regionId
- materialProfileId
- claimStatus
- extractionStatus
- mineFacilityId, optional
- localStockpileId
```

```text
MineFacility
- id
- depositId
- status
- supplyStockpileId
- oreStockpileId
- hourlyOrDailySupplyUse
- oreProductionIntervalHours
- orePerBatch
```

Mine behavior for Phase 1:

- inactive until established,
- consumes supplies while active,
- produces ore into local mine stockpile if supplied,
- pauses when supplies are missing or capacity is full.

#### Material / Discovery / Codex System

The material system should separate hidden truth from player knowledge.

Minimum hidden material profile:

```text
MaterialProfile
- id
- displayName
- variantNameForDebug
- hiddenProperties
- possibleRevealStages
```

Minimum discovery state:

```text
MaterialDiscoveryState
- materialProfileId
- knownAppearance
- knownTestResults[]
- knownAnalysisResults[]
- knownFieldNotes[]
- revealedProperties[]
- discoveryProgressByProperty
```

Minimum Codex entry UI:

- source/location,
- appearance/observed clue,
- tested properties,
- analysis results,
- known uses,
- unknowns,
- project links,
- field notes later.

For Phase 1, revealed properties can be explicit. The important architectural rule is that the Codex displays **known state**, not hidden material truth.

Implementation warning:

> Do not let the UI read hidden material profile fields directly. All player-facing material information should pass through the discovery state.

#### Logistics / Shipment System

Shipments are physical transfers between local stockpiles.

Minimum shipment fields:

```text
Shipment
- id
- originStockpileId
- destinationStockpileId
- cargoGoodType
- cargoAmount
- routeId or routePathIds[]
- currentRouteSegment
- progressHours
- totalTravelHours
- status
```

Status values:

```text
Preparing
Moving
Arrived
Cancelled
```

Phase 1 rules:

- cargo is removed from origin when shipment departs,
- cargo is not available at destination until arrival,
- shipment appears on the map while moving,
- arrival transfers cargo into the destination stockpile,
- route travel time depends on route and cargo type/load only if implemented.

Later extension points:

- escorts,
- raider interception,
- delays,
- loss/partial theft,
- route danger,
- weather,
- alternate paths,
- supply convoys for squads/guard posts.

#### Event / Notification System

Events should preserve what happened in the world. Notifications are just the visible surface.

Minimum event fields:

```text
EventLogEntry
- id
- timestampHour
- eventType
- title
- body
- relatedObjectIds[]
- severity
- isRead
```

Phase 1 event types:

- Survey Started,
- Survey Complete,
- Deposit Confirmed,
- Mine Established,
- Supplies Low,
- Shipment Departed,
- Shipment Arrived,
- Project Complete,
- Codex Updated,
- Phase 1 Complete.

Notifications should link back to relevant objects. For example, “Shipment Arrived” opens the shipment or destination stockpile; “Codex Updated” opens the material entry.

#### UI Panel System

The UI can be simple, but it should mirror the object model.

Minimum panels:

- Region Panel,
- Route Panel,
- Hearthmere Settlement Panel,
- Prospect Panel,
- Deposit/Mine Panel,
- Project Panel,
- Stockpile Panel,
- Shipment Panel,
- Material Codex Panel,
- Event Log,
- Phase 1 Summary Screen.

Panel design should follow one consistent pattern:

```text
Header
Known status
Local contents
Active project/shipment links
Available actions
Warnings or blockers
```

Every action button should explain what it consumes and where the required inputs are located.

Example:

```text
Establish Mine
Requires: 2 Labor Teams, 20 Supplies at Hearthmere, 36 hours
Creates: Redglass Mine, local mine stockpile
Note: Supplies must later be shipped to the mine to keep extraction active.
```

#### Debug and Tuning Tools

Debug tools are not optional for this prototype. The design depends on timing and scarcity, so tuning needs to be fast.

Minimum debug tools:

- advance time by 1 hour,
- advance time by 12 hours,
- advance time by 1 day,
- pause all projects,
- complete selected project,
- add supplies to Hearthmere,
- add supplies to mine,
- add ore to mine,
- teleport shipment to arrival,
- reveal selected prospect result,
- reveal selected material property,
- switch material variant,
- reset scenario.

Debug display should show:

- all stockpiles and contents,
- all active projects and blockers,
- current labor assignments,
- hidden material variant,
- hidden prospect results,
- current shipment states.

This is especially important because Phase 1 will fail or succeed based on tuning feel.

#### Recommended Implementation Order

The first implementation pass should avoid building all systems at once. Build in this order:

1. **Game state + scenario loader**
   Load the fixed map, Hearthmere, prospects, and starting economy values.

2. **Static map + selection panels**
   Click regions, routes, Hearthmere, and prospects. Show placeholder panels.

3. **Hourly time controls**
   Pause/play, speed, current hour/day, advance time manually.

4. **Population/labor/supply display**
   Show Hearthmere population, workforce, labor teams, supply stockpile, and supply production.

5. **Generic project system**
   Start and complete a dummy project using labor and time.

6. **Prospecting loop**
   Survey prospect sites; reveal false/mundane/valuable results.

7. **Material profile + first Codex entry**
   Confirm Redglass and create a basic Codex entry from known information.

8. **Claim deposit + establish mine**
   Use projects to claim and establish the mine. Create local mine stockpile.

9. **Mine supply use + ore production**
   Require supplies at the mine. Produce ore into mine stockpile if supplied.

10. **Shipment system**
    Move supplies to mine and ore to Hearthmere through visible route-based shipments.

11. **Testing / analysis projects**
    Consume sample or ore at Hearthmere and reveal material properties into the Codex.

12. **Forge output project**
    Convert local ore and labor into a meaningful Phase 1 material output.

13. **Phase 1 completion summary**
    Summarize what was discovered, moved, consumed, built, and left unknown.

14. **Debug/tuning pass**
    Add debug tools and tune timings/resources until the loop is understandable.

#### Phase 1 Non-Goals

Do not implement these in the first technical pass:

- raider AI,
- combat resolver,
- mobile squads,
- tactical battles,
- trade markets,
- money economy,
- specialists,
- diplomacy,
- stealth/concealment,
- complex weather,
- procedural map generation,
- full material physics,
- global inventory,
- detailed population demographics,
- morale/fatigue/injury systems.

Reserved fields or placeholder UI may exist where useful, but they should not distract from the non-combat discovery/logistics/economy slice.

#### Future Integration Notes

The Phase 1 architecture should leave clear places for later systems to attach:

- **Raiders** attach to the map, time, route, shipment, visibility, and event systems.
- **Squads** attach to population, labor/manpower, supplies, map movement, assignments, and shipments.
- **Combat** attaches to squads, raiders, routes, mines, settlements, equipment outputs, and event reports.
- **Trade** attaches to value/appeal, stockpiles, routes, settlements, shipments, money/barter, and external actors.
- **Specialists** attach to projects, facilities, labor assignments, research, forging, caravans, and capture/poaching risks.
- **Tactical battles** attach to conflict reports, squad state, equipment, material field discovery, injuries, and map locations.

Design principle:

> The first build should be small, but every important thing should already have a place in the world and a path to future pressure.



### 13.35 Phase 2 Raider Pressure and Combat Integration Plan

Phase 1 proves the non-combat discovery, population, labor, supply, logistics, project, and material-Codex loop. Phase 2 adds pressure from the living world without turning raiders into a separate minigame.

The goal of Phase 2 is not to build full war, diplomacy, tactical battles, or deep AI. The goal is to make the player care about the vulnerabilities Phase 1 already created: remote mines, supply shipments, ore caravans, route choice, local stockpiles, mobilization time, and material uncertainty.

Core integration principle:

> Raiders should threaten things the player already understands. Do not add raiders to hide a weak economy/logistics loop; add raiders when the player can clearly see what is being threatened and why.

#### Phase 2 Design Goal

Phase 2 should make the player think:

> I built a valuable supply chain. Now the world has noticed it, and I need to decide what is worth guarding, moving, delaying, or risking.

Raiders should emerge from the map, routes, visibility, and exposed value. They should not appear as an abstract pressure meter, global danger level, or scripted punishment event.

Phase 2 validates these questions:

- Does a visible raider presence make the ore chain feel worth defending?
- Does scouting provide useful warning without becoming tedious?
- Does route choice matter more once hostile actors can move through the same map?
- Does physical shipment risk make supplies and ore feel more real?
- Does the player understand why a caravan, mine, or stockpile was attacked?
- Does the first abstract combat result feed back into population, cargo, equipment, and material discovery?

#### Phase 2A — Passive Route Risk Placeholder

Before implementing full raider entities, Phase 2 may begin with a light route-risk layer. This is optional, but useful if visible raider movement is not ready yet.

Passive route risk should be treated as a temporary implementation bridge, not the desired final representation of pressure.

Prototype behavior:

- Ashen Pass is riskier than Old Pine Road.
- High-value shipments are more likely to trigger trouble.
- Unscouted routes have more uncertain risk.
- Escort, scouting, or cautious shipment size can reduce risk.
- A risky event may delay a caravan, damage cargo, or create a sighting notification.

This layer should not become a permanent board-game danger meter. It exists only to test whether route risk makes the Phase 1 logistics loop more interesting.

Do not expose a clean global risk bar if it can be avoided. The player should see information like:

- *Ashen Pass is poorly watched.*
- *Recent traffic has made the road more visible.*
- *A supply caravan reports being followed.*
- *Scouts recommend escorting valuable shipments through this route.*

Exit criteria for Phase 2A:

> The player understands that different routes carry different logistical risk, even before full raider entities exist.

#### Phase 2B — Raider Entities Without Combat

The first real raider implementation should add physical raider map entities before adding combat resolution.

Raiders should exist as visible, hidden, or last-seen actors on the map. They can move, watch, gather, shadow, withdraw, and approach exposed targets. They do not need to fight yet.

Minimum raider entity states:

| State | Meaning |
|---|---|
| **Hidden** | Raider exists outside player vision. |
| **Spotted** | Raider entity is currently visible to a settlement, squad, scout, caravan, or guard post. |
| **Last Seen** | Raider was visible recently, but current location is uncertain. |
| **Watching** | Raider is near a route, mine, or shipment target. |
| **Gathering** | Multiple raider groups or a stronger raider party is forming near a route/camp. |
| **Shadowing** | Raider is following or paralleling a caravan route. |
| **Approaching Target** | Raider is moving toward a mine, caravan, or settlement. |
| **Withdrawing** | Raider is leaving after being spotted, after an aborted attack, or after a loss. |

Minimum raider movement:

- Blackbanner Camp can spawn or house raider parties.
- Raider parties can move to Ashen Pass, Redglass Foothills, Old Pine Road, or route segments.
- Raiders should prefer exposed value: active mine, large stockpile, repeated shipments, high-value ore cargo, or under-scouted routes.
- Raiders should sometimes withdraw if visible defenses are strong or if they are spotted too early.

Minimum player-facing notifications:

- **Raiders sighted near Ashen Pass.**
- **A raider party is watching the mine road.**
- **A caravan crew spotted riders shadowing the route.**
- **Scouts report raiders gathering near Blackbanner Camp.**
- **Raiders are moving toward Redglass Foothills.**

These notifications should jump to the relevant map object. The source of truth remains the map.

Exit criteria for Phase 2B:

> Raider entities make the player change route, shipment, scouting, or labor priorities even before combat exists.

#### Phase 2C — Scouting, Vision, and Guard Posts

Raiders only work if the player has a fair way to notice them. Phase 2 should therefore connect raider pressure to vision and scouting.

Minimum vision sources:

- Hearthmere sees nearby local movement.
- Active caravans can spot raiders near their route.
- Survey parties or scout assignments can reveal nearby raider movement.
- Temporary guard posts reveal movement in their assigned region/route.
- Mine guards reveal raiders approaching the mine.

Vision should be simple for Phase 2. It does not need full stealth values yet.

Prototype visibility rules:

- A raider inside friendly vision becomes visible.
- A raider leaving vision becomes last-seen for a limited time.
- Guard posts and scouts expand the area where raiders can be spotted.
- Night may reduce sighting reliability if the day/night foundation is implemented.
- Last-seen information can become stale.

This keeps the system diegetic. The warning is seeing raiders, not watching a meter fill.

Future stealth/intelligence expansion:

- raider stealth values,
- scout detection values,
- tracks and smoke clues,
- local informants,
- bribed raiders,
- rumors,
- false sightings,
- decoy caravans,
- misinformation,
- concealment of mining activity.

These are not required for Phase 2 unless visible raider movement is already working.

#### Phase 2D — First Combat Resolver: Caravan Ambush

The first actual combat/context resolver should be **caravan ambush**. It connects the most existing systems with the least new scope.

A caravan ambush involves:

- a shipment already moving on a route,
- raiders physically close enough to intercept,
- cargo with local value,
- route context,
- caravan speed,
- optional escort,
- optional scouting/guard-post warning,
- possible cargo loss,
- possible population loss if an escort exists,
- possible material field discovery if prototype equipment is involved.

Main question:

> Does the shipment reach its destination, get delayed, get partially stolen, or get lost?

Minimum caravan ambush outcomes:

| Outcome | Result |
|---|---|
| **Avoided Ambush** | Raiders fail to engage or withdraw after spotting escort/guards. |
| **Clean Delivery** | Caravan reaches destination; raiders are driven off or never close. |
| **Delayed Delivery** | Caravan survives but arrives late. |
| **Costly Delivery** | Cargo arrives, but escort suffers wounded/killed losses. |
| **Partial Theft** | Some cargo is stolen; caravan continues or returns. |
| **Total Cargo Loss** | Cargo is lost; caravan may be destroyed or scattered. |
| **Counter-Raid Success** | Escort wins decisively and weakens local raider presence. |

Minimum inputs:

- cargo type and amount,
- cargo value,
- route risk/context,
- caravan speed,
- raider attack/speed,
- escort attack/defense/speed if present,
- equipment modifiers if present,
- supply status if present,
- modest random variance.

For the first implementation, the result can be mostly formulaic. It should still explain why the outcome happened.

Example result text:

```text
Caravan Ambushed at Ashen Pass

Cargo: 12 Redglass Ore
Escort: Hearthmere Improvised Militia
Outcome: Costly Delivery

Results:
- 10 Redglass Ore delivered to Hearthmere
- 2 Redglass Ore lost
- 3 militia wounded
- 1 militia killed
- Caravan delayed by 6 hours

Notes:
- Escort presence prevented total cargo loss.
- Raiders withdrew toward Blackbanner Camp.
```

If Redglass equipment is used:

```text
Field Note Added:
Redglass shields performed unusually well when raiders used firepots.
Codex discovery progress increased.
```

Exit criteria for Phase 2D:

> A player who understands Phase 1 logistics should understand why an ambush happened, what was lost, and how earlier decisions could have changed the outcome.

#### Phase 2E — Mine Raid

After caravan ambush works, add mine raids. Mine raids test the danger of letting valuable goods pile up remotely.

Mine raid trigger conditions:

- local ore or supplies stockpile is valuable enough,
- mine is under-guarded,
- raider party is close enough,
- route/region visibility is weak,
- raiders have had time to observe the target.

Main question:

> Do raiders steal ore/supplies, damage the mine, or get repelled?

Minimum outcomes:

- raid repelled,
- minor theft,
- major theft,
- mine damaged/paused,
- guard squad wounded/killed,
- raiders withdraw with stolen cargo.

Mine raids should reinforce the physical-stockpile rule:

> Ore sitting at the mine is not safe simply because the player owns the mine.

Exit criteria for Phase 2E:

> The player learns that stockpile timing, shipment cadence, local guards, and route safety all matter.

#### Phase 2F — Settlement Defense and Camp Assault

Only after caravan ambush and mine raid work should Phase 2 add the full local threat arc.

Settlement defense is the primary defeat context. It should be serious and relatively rare, not the first punishment.

Settlement defense tests:

- Hearthmere local defense,
- mobilized squads present at home,
- previous raider successes/failures,
- population consequences,
- supply/equipment preparedness.

Camp assault is the primary military victory context. It should require the player to deliberately create military capacity and accept the population/supply risk of using it.

Camp assault tests:

- squad creation,
- equipment choice,
- scouting,
- supplies for away operation,
- speed/withdrawal,
- raider camp strength,
- prior raider losses,
- Redglass weapon/armor implications.

Minimum endings unlocked at this stage:

- **Military victory:** Blackbanner Camp cleared or dispersed.
- **Defensive/logistics victory:** ore chain secured through a major raider threat.
- **Defeat:** Hearthmere sacked after defenses fail.

Exit criteria for Phase 2F:

> The full v0.1 scenario has a local beginning, middle, and end: discovery creates value, value attracts raiders, the player responds through logistics/equipment/squads, and the scenario resolves through defense, discovery, or military action.

#### Phase 2 Data Additions

Phase 2 should extend the Phase 1 domain model rather than replace it.

New or activated objects:

| Object | Purpose |
|---|---|
| **Raider Party** | Hostile map entity with location, state, strength, speed, visibility, and current target. |
| **Raider Camp** | Source/home for raider parties and local threat strength. |
| **Squad** | Player mobile unit created from population/manpower. |
| **Assignment** | Guard, escort, scout, patrol, recover, attack. |
| **Guard Post** | Temporary or light region/route watch position staffed by squad/manpower. |
| **Combat Report** | Stores outcome, losses, cargo changes, equipment notes, and discovery progress. |
| **Sighting Record** | Current or last-seen raider information tied to map vision. |

New/activated fields:

- route visibility,
- route recent traffic,
- shipment value,
- raider interest target,
- raider state,
- entity speed,
- squad manpower,
- squad equipment coverage,
- squad condition,
- wounded/recovering count,
- killed count,
- combat outcome summary,
- field discovery contribution.

#### Phase 2 UI Additions

Phase 2 should add UI only where the player needs to understand pressure and respond.

Minimum UI additions:

- visible raider map icons when spotted,
- last-seen raider markers,
- raider unit panel,
- squad creation panel,
- squad panel,
- assignment controls,
- guard post controls,
- sighting notifications,
- caravan ambush result screen,
- cargo loss display,
- casualty display,
- field discovery note display.

Do not add a large war-management interface yet.

#### Phase 2 Implementation Order

Recommended order:

1. Add route/passive risk placeholders if useful.
2. Add raider entity data and map icons.
3. Add raider movement without combat.
4. Add vision/sighting/last-seen behavior.
5. Add basic squad creation and movement.
6. Add escort assignment to caravan.
7. Add caravan ambush resolver.
8. Add combat report UI.
9. Add casualty and cargo consequences.
10. Add field discovery integration.
11. Add mine raid resolver.
12. Add settlement defense resolver.
13. Add camp assault resolver and local scenario endings.

#### Phase 2 Acceptance Criteria

Phase 2 is ready when a playtester can say:

- I understood what the raiders were threatening.
- I saw at least one raider or last-seen marker before a major attack.
- I changed a route, shipment, escort, scouting, or guard decision because of raider movement.
- I understood why a caravan ambush or mine raid happened.
- I understood what was lost: cargo, time, people, equipment, supplies, or opportunity.
- I saw how Redglass equipment or material knowledge could affect a conflict.
- I wanted to replay with a different material use, route plan, or security posture.

Phase 2 fails if:

- raiders feel like random pop-up events,
- scouting feels irrelevant,
- ambush outcomes feel arbitrary,
- cargo loss does not matter,
- casualties do not affect population/labor,
- or combat feels detached from discovery/logistics.

#### Phase 2 Non-Goals

Do not implement these yet unless the simpler raider/logistics layer is already working:

- full raider diplomacy,
- bribery or negotiated truces,
- detailed stealth/concealment,
- informant networks,
- multiple enemy factions,
- full tactical battles,
- morale/rout systems,
- unit experience/veterancy,
- detailed equipment durability,
- siege systems,
- large armies,
- coalition AI,
- settlement conquest.

Design principle:

> Phase 2 should make the Phase 1 economy vulnerable, not replace it with a combat game. The player should still be thinking about discovered materials, people, supplies, routes, stockpiles, and time.



### 13.36 Phase 2 Implementation Checklist

Phase 2 begins after the no-combat Phase 1 loop is playable and at least mildly interesting on its own. Phase 2 should not replace that loop with a separate combat game. It should make the existing economy, logistics, material, shipment, and population systems vulnerable.

Implementation principle:

> Add raiders as pressure on the physical world the player already understands: routes, shipments, mine stockpiles, supplies, squads, people, and time.

This checklist turns the Phase 2 raider integration plan into concrete build tasks.

#### Phase 2A — Passive Route Risk Placeholder *(Optional Bridge)*

Use this only if full raider entities are not ready yet, but the team wants to begin testing route pressure.

Build tasks:

- Add a simple risk label to routes: **safe**, **risky**, **unknown**, or **dangerous**.
- Mark Ashen Pass as riskier than Old Pine Road.
- Let shipment panels display route risk and travel time.
- Let scouting or patrol assignments reduce uncertainty, even if no raider entity is present yet.
- Let high-value shipments through risky routes generate warning text.
- Do not yet resolve full combat unless the caravan ambush resolver is ready.

Acceptance check:

- The player understands that route choice has consequences before combat exists.
- The fast route feels tempting but exposed.
- The slow route feels safer but costly in time.

Cut line:

- This phase can be skipped if visible raider entities are implemented first.
- Do not let passive risk become the long-term model; raiders should eventually be physical actors.

#### Phase 2B — Raider Entity Data and Map Presence

Raiders should first exist as simple map actors before they can fight.

Build tasks:

- Create a **RaiderGroup** or equivalent data object.
- Give each raider group:
  - id,
  - name or label,
  - location,
  - destination or current route,
  - approximate strength,
  - speed,
  - behavior state,
  - visibility state,
  - last-seen location/time,
  - current interest or target, if known internally.
- Add raider map icons when visible.
- Add last-seen markers when a previously visible group leaves vision.
- Add simple behavior states:
  - scouting,
  - watching route,
  - gathering,
  - shadowing shipment,
  - moving to target,
  - raiding,
  - retreating.
- Allow raiders to move along the same route graph as caravans and squads.
- Spawn or activate a small raider group after valuable activity begins: confirmed deposit, active mine, repeated shipments, or high-value cargo.

Acceptance check:

- The player can see raiders physically moving when they are in vision.
- Raiders feel like actors in the world, not random pop-up events.
- Sighting a raider creates a natural warning.

Do not add yet:

- diplomacy,
- bribery,
- morale,
- detailed stealth,
- multiple raider factions,
- full strategic AI.

#### Phase 2C — Vision, Scouting, and Sighting Notifications

Raiders become strategically meaningful when the player can see, miss, or partially track them.

Build tasks:

- Add basic vision ranges for Hearthmere, squads, guard posts, caravans, and possibly mines.
- Add region/route scouting state: unscouted, recently scouted, watched, or stale.
- Allow player squads to scout a region or route.
- Allow temporary guard posts to provide local vision.
- Reveal raider groups when they enter friendly vision.
- Hide or convert raiders to last-seen markers when they leave vision.
- Add short sighting notifications:
  - **Raiders sighted near Ashen Pass.**
  - **A raider party is watching the mine road.**
  - **Scouts report raiders moving toward Redglass Foothills.**
  - **A caravan crew spotted riders shadowing the route.**
- Link each notification back to the relevant map object or last-seen marker.

Acceptance check:

- Better scouting gives the player more warning.
- Poor scouting does not create artificial surprise; it simply leaves the player blind.
- The player changes route, escort, guard, or timing decisions because of what they see.

Cut line:

- Do not build complex stealth/concealment yet.
- Do not build rumor/informant/bribery systems yet.
- Sightings are enough for the first raider pass.

#### Phase 2D — Squad Creation, Movement, and Assignments

If Phase 1 did not implement mobile squads yet, Phase 2 must add them before combat.

Build tasks:

- Add **Raise Improvised Militia** as a non-instant Hearthmere project.
- Add **Prepare Proper Watch Squad** as a longer project, if basic gear exists or can be produced.
- Ensure squad creation removes manpower from available workforce.
- Ensure squad dissolution at Hearthmere returns surviving manpower after a short delay.
- Add squad movement along routes.
- Add carried supply buffer for squads.
- Add assignment states:
  - guard Hearthmere,
  - guard mine,
  - escort caravan,
  - scout region/route,
  - patrol route,
  - establish temporary guard post,
  - attack/intercept visible raider.
- Make squad assignments visible on the map and in panels.

Acceptance check:

- Creating a squad feels like committing people, not spawning a free unit.
- Assigning a squad to one job leaves other objects uncovered.
- The player can understand where the squad is, what it is doing, and what it is protecting.

Do not add yet:

- split/recombine,
- unit experience,
- individual traits,
- per-soldier equipment,
- tactical formations,
- morale/rout systems.

#### Phase 2E — Escort Assignment and Shipment Protection

Before combat resolves, caravans need a simple way to be protected.

Build tasks:

- Let the player assign an eligible squad to escort a shipment before departure.
- Attach the escort physically to the caravan.
- Show escort status in the shipment panel.
- Move escort and caravan together while attached.
- Let the escort detach at the destination or at safe route nodes.
- Prevent the same squad from guarding the mine and escorting a shipment simultaneously.
- Display whether a shipment is unescorted, lightly escorted, or well escorted.

Acceptance check:

- The player understands the escort tradeoff.
- A guarded caravan feels safer but costs a squad assignment.
- The mine or Hearthmere may be less protected while the escort is away.

#### Phase 2F — Caravan Ambush Resolver *(First Combat Context)*

The caravan ambush should be the first real combat resolver because it connects the most systems.

Build tasks:

- Add ambush trigger logic when raiders and a shipment overlap or when raiders commit from nearby.
- Use simple inputs:
  - cargo value,
  - route context,
  - caravan speed,
  - escort presence,
  - escort attack/defense,
  - raider attack/strength,
  - raider speed,
  - supply status,
  - relevant material/equipment modifiers if present.
- Resolve outcome bands:
  - clean delivery,
  - delayed delivery,
  - costly delivery,
  - partial theft,
  - total loss,
  - counter-raid success.
- Apply cargo consequences to local stockpiles.
- Apply escort casualties if combat occurs.
- Apply raider losses or retreat state when relevant.
- Trigger field discovery progress when Redglass equipment is used in a relevant context.

Acceptance check:

- The player understands why the ambush happened.
- Cargo outcomes are clear.
- Escort and route decisions visibly matter.
- Ambushes threaten the logistics chain rather than feeling like random punishment.

Cut line:

- Do not implement mine raids, settlement attacks, or camp assaults until caravan ambushes are understandable and fun.

#### Phase 2G — Combat Result UI

The result screen is critical because combat ties back into population, logistics, and discovery.

Build tasks:

- Create a combat/result report panel for caravan ambushes.
- Display:
  - conflict type,
  - location/route,
  - objective outcome,
  - cargo delivered/lost/stolen/delayed,
  - returned ready survivors,
  - wounded/recovering,
  - killed,
  - equipment lost/recovered, if tracked,
  - supply impact,
  - raider losses/retreat if known,
  - field discovery notes,
  - updated Codex link if relevant.
- Update population/workforce counts after casualties.
- Send wounded to Hearthmere recovery if appropriate.
- Show local stockpile changes clearly.

Acceptance check:

- The player can immediately tell what happened and why it matters.
- Casualties feel like population losses, not abstract HP damage.
- Cargo loss and delay are tied back to physical locations.
- Material behavior appears as discovery, not just combat text.

#### Phase 2H — Mine Raid Resolver

Add mine raids only after caravan ambushes work.

Build tasks:

- Let raiders target Redglass Foothills when exposed ore or supplies accumulate.
- Use simple inputs:
  - mine stockpile value,
  - mine guard presence,
  - guard supply status,
  - nearby patrol/guard post,
  - raider strength/speed,
  - mine preparedness.
- Resolve outcome bands:
  - raid repelled,
  - minor theft,
  - major theft,
  - mine damaged/paused,
  - guard casualties.
- Update mine stockpiles locally.
- Pause or slow mine projects if damage/disruption occurs.
- Trigger notifications and crisis slowdown.

Acceptance check:

- Leaving valuable ore piled up at the mine feels risky.
- Guarding the mine competes with escorting shipments.
- Mine raids threaten production rather than acting as arbitrary damage events.

#### Phase 2I — Settlement Defense Resolver

Settlement defense is the primary defeat pathway and should be added after smaller raid contexts work.

Build tasks:

- Define Hearthmere's immobile settlement defense value.
- Let present squads contribute to defense.
- Let armor/shields improve defense if equipped.
- Let prior raider losses weaken incoming attacks.
- Resolve outcome bands:
  - hold firm,
  - damaged hold,
  - emergency defense,
  - sack/pillage defeat.
- Apply consequences:
  - supply loss,
  - population killed/wounded,
  - facility/project delay,
  - scenario defeat if sacked.

Acceptance check:

- Hearthmere is not helpless, but leaving it exposed matters.
- Settlement attacks feel like the culmination of failures or serious overextension, not the first punishment.
- Defeat clearly flows from logistics/security breakdown.

#### Phase 2J — Raider Camp Assault Resolver

The camp assault is the primary military victory path.

Build tasks:

- Define Blackbanner Camp as a hostile map object with camp strength.
- Let scouting reveal approximate camp strength or preparation.
- Let player squads attack the camp if they can reach it and have enough supplies.
- Use simple inputs:
  - player attack,
  - player defense,
  - equipment coverage,
  - supply status,
  - scouting/camp knowledge,
  - raider camp strength,
  - previous raider losses.
- Resolve outcome bands:
  - camp cleared,
  - camp damaged,
  - costly victory,
  - failed assault,
  - disaster.
- End scenario on camp cleared if military victory is enabled.

Acceptance check:

- Clearing the camp feels earned through preparation, not just clicking attack.
- Previous defensive wins can weaken the camp.
- Weapon-focused Redglass use has an obvious payoff here.

#### Phase 2K — Field Discovery Integration

Combat should feed the Material Codex.

Build tasks:

- Define which combat contexts can test which material properties.
- Add discovery progress from relevant field use:
  - Redglass weapons used in attack/counterattack,
  - Redglass armor/shields used in defense,
  - fire exposure during ambush/raid/settlement attack,
  - burden/speed issues during pursuit or escape if implemented.
- Add field notes to the Codex after meaningful events.
- Allow combat result UI to link to the updated Codex entry.
- Avoid revealing irrelevant properties from unrelated contexts.

Acceptance check:

- Combat reveals material behavior because the context tested it.
- The player can see why a property was discovered.
- Field discovery complements research rather than replacing it entirely.

#### Phase 2L — Scenario Endings and Summary

Once raiders and combat exist, Phase 2 should support local scenario endings.

Build tasks:

- Add military victory: Blackbanner Camp cleared or dispersed.
- Add defensive/logistics victory if feasible: Redglass chain secured through a major raider threat.
- Add defeat: Hearthmere sacked/pillaged.
- Add scenario summary showing:
  - what the player discovered,
  - what material use they chose,
  - what happened to the ore chain,
  - what happened to Hearthmere's people,
  - what raider threat remains or was removed,
  - what remains unknown.

Acceptance check:

- Ending reflects the player's strategic choices.
- Victory is not only map-painting.
- Defeat explains the collapse in terms of people, supplies, routes, and missed threats.

#### Phase 2 Debug and Tuning Tools

Phase 2 will be difficult to tune without debug controls.

Build tasks:

- Spawn raider group at selected region/route.
- Toggle raider visibility.
- Set raider behavior state.
- Force caravan ambush.
- Force mine raid.
- Adjust route travel time.
- Adjust squad strength/speed/supply.
- Adjust cargo amount/value.
- Add/remove Redglass equipment.
- Trigger field discovery.
- Complete recovery timer.
- Reset local threat state.

Acceptance check:

- Designers can reproduce ambushes and mine raids quickly.
- Combat outcomes can be tuned without replaying the whole opening every time.
- Material field discovery can be tested in isolation.

#### Phase 2 Cut Line

If scope gets tight, preserve the smallest pressure loop:

1. visible raider entities,
2. scouting/last-seen behavior,
3. escort assignment,
4. caravan ambush resolver,
5. combat result UI with cargo/casualty consequences,
6. field discovery from combat.

Cut or delay:

- mine raid,
- settlement defense,
- camp assault,
- full scenario victory/defeat,
- passive route risk if visible raiders work,
- advanced stealth,
- diplomacy/bribery,
- detailed equipment loss,
- morale/rout systems.

Minimum Phase 2 success statement:

> Raiders physically threaten a shipment the player understands, the player can scout or escort to manage the danger, the ambush outcome affects cargo and people, and combat can reveal something about the material.


### 13.37 Phase 2 UX Flow — Raider Sightings, Ambushes, and Aftermath

Phase 2 adds raiders, scouting, escorts, and the first abstract combat contexts to the Phase 1 discovery/economy/logistics loop. The UX goal is not to create a separate combat minigame. The UX goal is to make the player understand that the same physical systems they learned in Phase 1 are now vulnerable.

Phase 2 should answer five player questions clearly:

1. **What did I see?** — raiders, last-known raider movement, a threatened route, or an attack.
2. **What is at risk?** — cargo, supplies, ore, mine stockpiles, squads, Hearthmere, or time.
3. **What can I do?** — scout, escort, delay, reroute, guard, mobilize, attack, or accept risk.
4. **What happened?** — cargo delivered/lost, casualties, wounds, stolen goods, delays, discoveries.
5. **What should I do next?** — recover, resupply, reroute, change equipment plans, reinforce, or strike the camp.

Design principle:

> Raider UX should make pressure legible without making it feel scripted. The player should see actors in the world, understand what they threaten, and respond through existing map objects.

#### Phase 2 Opening State

Phase 2 should begin from the same foundation as Phase 1, but with raiders enabled.

At scenario start or shortly after the ore chain becomes active, the player should already understand:

- Hearthmere has people, supplies, labor, local stockpiles, and projects.
- Prospects must be surveyed before they become useful deposits.
- The mine consumes supplies and produces ore locally.
- Ore and supplies move by physical shipment.
- Routes have distance, travel time, and exposure.
- The Material Codex grows as the player tests, researches, and uses materials.

Raiders should be introduced only after the player can recognize what they threaten. A raider sighting near Ashen Pass should matter because the player knows that shipments pass through Ashen Pass.

#### First Raider Sighting

The first raider sighting should be simple and map-driven.

Example notification:

```text
Raiders sighted near Ashen Pass.
A small Blackbanner party was spotted near the road between Redglass Foothills and Hearthmere.
```

Clicking the notification should jump to the map location and select either the raider entity or the region/route where it was spotted.

Displayed information for a first sighting:

- raider party icon on the map, if still visible,
- last-seen marker if the party has moved out of vision,
- approximate strength such as Small / Moderate / Large,
- last-seen time,
- observed behavior such as scouting, watching, moving, gathering, or shadowing,
- nearby valuable objects such as caravan, mine, supply route, or stockpile,
- player vision source, if relevant: scout, guard post, caravan crew, settlement watch, or passing squad.

The first sighting should not open a long story event by default. It should create awareness and point the player toward a physical decision surface.

Desired player thought:

> Raiders are real actors on the map, and they are near something I care about.

#### Inspecting a Raider Entity

Selecting a visible or last-seen raider entity should open a small hostile-actor panel.

Minimum visible fields:

- **Name / Type:** Blackbanner Raider Party, Blackbanner Scouts, Blackbanner Warband, etc.
- **Visibility State:** visible, last seen, uncertain, hidden until attack.
- **Last Known Location:** region or route.
- **Approximate Strength:** weak, small, comparable, strong, unknown.
- **Speed Impression:** fast, normal, slow, unknown.
- **Observed Behavior:** scouting, watching route, shadowing caravan, gathering, moving toward mine, retreating.
- **Last Seen:** current, 2 hours ago, yesterday, etc.
- **Possible Threatened Objects:** shipment, mine, route, guard post, Hearthmere, unknown.

Minimum actions from the raider panel:

- send scout / patrol if an eligible squad exists,
- intercept / attack if an eligible squad can reach them,
- assign escort to threatened shipment,
- guard threatened mine or route,
- jump to threatened object,
- ignore / accept risk.

The panel should avoid precise omniscient information unless player scouting justifies it. The player should not always know exact strength, exact target, or exact attack timing.

Design rule:

> Raider information should be useful, not perfect. Better vision and scouting produce clearer decisions.

#### Responding to a Raider Sighting

After a raider sighting, the player's response should happen through existing map objects and assignments.

Common response actions:

1. **Escort shipment**
   The player selects the shipment or squad and assigns a squad to travel with the caravan.

2. **Delay shipment**
   The player pauses a planned shipment until the route is safer, the escort arrives, or daylight returns.

3. **Reroute shipment**
   The player sends the caravan through Old Pine Road instead of Ashen Pass, if the route is available.

4. **Scout route**
   The player sends a squad to Ashen Pass or Old Pine Road to reveal raider movement before committing cargo.

5. **Guard mine**
   The player assigns a squad to Redglass Foothills if raiders appear near the mine or stockpile.

6. **Mobilize squad**
   The player starts raising improvised militia or preparing a proper watch squad if no mobile force is ready.

7. **Attack or intercept**
   The player orders an available squad to engage a visible raider party if the risk is acceptable.

8. **Accept risk**
   The player continues the shipment or mine operation despite danger because another priority is more important.

The UI should make response time clear. Mobilization, movement, and escort assignment are not instant. If raiders are already close, a late response may not arrive in time.

Desired player thought:

> I have choices, but every choice costs time, labor, people, supplies, or route efficiency.

#### Shipment Threat UX

When a shipment is threatened, the shipment panel should become the central decision surface.

A shipment panel should show:

- cargo type and amount,
- cargo value / importance,
- origin and destination,
- current route,
- current location,
- ETA,
- escort status,
- route visibility,
- known/last-seen raiders near the route,
- current risk impression based on known information.

Example risk language:

```text
Known Risk: Raiders last seen near Ashen Pass 3 hours ago.
Escort: None.
Caravan Speed: Slow.
Cargo: 12 Redglass Ore.
```

The UI should avoid saying “75% ambush chance” unless a later design deliberately adds explicit risk values. For Phase 2, qualitative risk is enough.

Possible shipment actions:

- assign escort,
- delay departure,
- continue current route,
- reroute at a safe node,
- recall if still near origin,
- split shipment later, if implemented,
- inspect nearby raider sighting.

Design rule:

> The player should understand why a shipment is risky before it is attacked.

#### Caravan Ambush UX

The first combat UX should be the caravan ambush because it connects the most systems.

When an ambush begins:

- game speed should drop to Slow or pause based on settings,
- the map should focus on the ambush location,
- the caravan and raider entities should be visible if appropriate,
- the player should receive a concise alert.

Example alert:

```text
Caravan Ambushed — Ashen Pass
Blackbanner raiders have struck the Redglass shipment.
Cargo: 12 Redglass Ore
Escort: Hearthmere Watch Squad
```

If no player response is possible because combat is abstract and immediate, the result screen can follow directly. If a short pre-resolution choice is desired, keep it minimal:

- stand and defend cargo,
- abandon part of cargo and flee,
- attempt breakthrough,
- escort counterattack.

These choices should only be added if they are mechanically meaningful. Otherwise, resolve automatically using the current squad, cargo, route, speed, and equipment context.

#### Combat Result Screen

The combat result screen should explain consequences across multiple systems.

Minimum sections:

1. **Outcome Summary**
   - delivered, delayed, partial theft, total loss, raiders repelled, escort wounded, etc.

2. **Cargo Outcome**
   - cargo delivered,
   - cargo stolen,
   - cargo destroyed/lost,
   - cargo delayed,
   - current cargo location.

3. **People and Casualties**
   - returned ready,
   - wounded/recovering,
   - killed,
   - workforce/population impact.

4. **Equipment Outcome**
   - equipment used,
   - equipment lost/damaged if tracked,
   - Redglass weapons/armor performance if relevant.

5. **Supply Impact**
   - supplies consumed,
   - supplies lost/stolen,
   - route or remote-site supply consequences.

6. **Material Discovery**
   - field note added,
   - discovery progress gained,
   - Codex updated if threshold reached,
   - link to Codex entry.

7. **Aftermath Links**
   - jump to Hearthmere,
   - jump to caravan/current cargo,
   - jump to wounded recovery,
   - jump to raider last-seen location,
   - jump to affected route or mine.

Example result summary:

```text
Costly Delivery
The Redglass caravan broke through the ambush and reached Hearthmere 6 hours late.

Cargo:
- 10 Redglass Ore delivered
- 2 Redglass Ore lost

Hearthmere Watch Squad:
- 14 returned ready
- 4 wounded/recovering
- 2 killed

Field Note:
- Redglass shield plating held unusually well against firepots.
- Codex progress gained: Thermal Response
```

The result should make the player immediately understand what changed and where to act next.

Design rule:

> The combat result screen should not just say who won. It should translate conflict into cargo, people, supplies, equipment, time, and knowledge.

#### Aftermath UX

After a raider event, the player should return to the map with clear visible consequences.

Possible aftermath states:

- wounded people appear in Hearthmere's recovery pool,
- killed people reduce total population/workforce potential,
- cargo appears at Hearthmere, remains in caravan, or disappears into raider hands,
- stolen cargo may create a last-seen raider trail or future camp value,
- mine or route may show disruption,
- shipment route may remain active but risky,
- Codex may show a new field note,
- squad may be Ready, Wounded/Recovering, or destroyed,
- raider party may be weakened, retreating, or last seen.

The immediate next actions should be available from the affected objects:

- recover squad,
- raise replacement militia,
- pause shipment route,
- reroute future shipments,
- guard mine,
- scout raider retreat,
- prepare retaliation,
- research discovered material behavior.

Desired player thought:

> That attack changed the world state. I can recover, adapt, or retaliate.

#### Mine Raid UX

Mine raids should use similar UX, but with the mine as the primary decision surface.

Before a raid, the player may see raiders near Redglass Foothills, raiders moving toward the mine, or a lightly guarded stockpile accumulating.

When a mine raid occurs:

- focus the map on Redglass Foothills,
- show mine stockpile and guard status,
- resolve the raid,
- show consequences to ore, supplies, workers, guards, and mine operation.

Mine raid result screen sections:

- raid outcome,
- ore stolen/lost/protected,
- supplies stolen/lost/protected,
- workers/guards killed or wounded,
- mine operation status: active, delayed, paused, damaged,
- raider retreat or last-seen location,
- field discovery if relevant.

The mine panel after a raid should show obvious changed state:

```text
Redglass Mine
Status: Disrupted — repairs/resupply required
Ore Stockpile: 4 / 30
Supplies: 0 / 20
Assigned Guards: Wounded/Recovering
```

Design rule:

> A mine raid should feel like damage to a physical production chain, not like an abstract penalty.

#### Settlement Defense UX

Settlement attacks should be rare and serious. The player should experience them as escalation, not routine harassment.

Before a settlement attack, there should usually be signs:

- multiple raider groups gathering,
- prior successful raids emboldening the camp,
- Hearthmere left without mobile defense,
- supply/equipment disruption,
- visible movement toward Hearthmere.

When Hearthmere is attacked:

- pause or crisis-slow the game,
- focus the map on Hearthmere,
- show settlement defense, present squads, and available equipment,
- resolve the abstract defense,
- show consequences to population, supplies, facilities, and scenario state.

Settlement defense result should make the stakes clear:

- Hold Firm,
- Damaged Hold,
- Emergency Defense,
- Sack / Pillage.

If Hearthmere is sacked, the defeat summary should explicitly connect the collapse to missed or failed systems:

- ore chain exposed too long,
- escorts lost,
- settlement left undefended,
- raiders strengthened by stolen supplies/ore,
- population losses became unrecoverable.

Design rule:

> Settlement defense is the consequence of the local crisis reaching home. It should not be the first punishment.

#### Raider Camp Assault UX

The camp assault should feel like a deliberate strategic choice, not just the next mandatory button.

Before attacking Blackbanner Camp, the player should be able to inspect:

- approximate camp strength,
- known raider losses,
- route to camp,
- supply requirement for the attacking squad,
- squad attack/defense/speed,
- equipment coverage,
- scouting knowledge,
- expected risk category.

The camp panel should offer an attack action only if the player has an eligible mobile squad that can reach the camp.

Example camp panel language:

```text
Blackbanner Camp
Known Strength: Moderate
Recent Losses: A raider party was repelled near Ashen Pass.
Approach Route: Old Pine Road / Ashen Pass
Recommended: Scout before assault.
```

After camp assault, the result screen should show:

- camp cleared/damaged/intact,
- player casualties,
- raider losses,
- captured or recovered cargo, if any,
- rescued captives/refugees, if implemented,
- material field discoveries, if relevant,
- victory summary if camp cleared.

Design rule:

> Camp assault is how the player converts local defense and preparation into a decisive resolution.

#### Sightings and Notifications Style

Phase 2 notifications should be concise and actionable.

Good notification examples:

- **Raiders sighted near Ashen Pass.**
- **Blackbanner party shadowing Redglass shipment.**
- **Raiders moving toward Redglass Foothills.**
- **Caravan ambushed on Ashen Pass.**
- **Redglass Mine raided.**
- **Hearthmere Watch Squad has wounded survivors.**
- **Field discovery added to Redglass Codex.**

Avoid overusing dramatic event cards for ordinary sightings. Eventually, hostile movement should be common across the map. The notification system should help awareness, not turn every raider scout into a cinematic interruption.

Design rule:

> Notifications point to world objects. They should not replace scouting, map visibility, or physical actor behavior.

#### Phase 2 UX Acceptance Criteria

Phase 2 UX passes when a player can explain:

- where raiders were seen,
- what the raiders threatened,
- how they could have responded,
- why an ambush or raid happened,
- what was lost or saved,
- what happened to their people,
- what changed in stockpiles/routes/projects,
- whether the material revealed anything new,
- and what they want to do next.

Phase 2 UX fails if:

- attacks feel random,
- raider intent is invisible even with scouting,
- the player does not know what object was threatened,
- cargo loss feels like a menu penalty rather than physical theft,
- casualties do not feel connected to population,
- field discovery appears unrelated to combat context,
- or the player cannot tell how to recover/adapt afterward.

Minimum Phase 2 UX success statement:

> The player sees raiders as physical actors, understands what they threaten, responds through scouts/escorts/routes/guards, and reads combat aftermath as changes to the world rather than an isolated battle result.



### 13.38 Phase 2 Playtest Criteria and Tuning Targets

Phase 2 adds raiders, scouting, escorts, ambushes, mine raids, and abstract combat to the Phase 1 discovery/economy/logistics loop. The goal is not to prove the final tactical battle system yet. The goal is to determine whether hostile pressure makes the existing physical economy more interesting.

Core test question:

> Are raiders making the Phase 1 economy more interesting, or are they merely interrupting it?

Phase 2 should pass when the player feels that raiders are threatening things they already understand: shipments, local stockpiles, supplies, routes, mine output, labor commitments, squads, and Hearthmere's people.

Design rule:

> Raider pressure is successful only if the player understands what was threatened, why it was vulnerable, what options they had, and how the outcome changed the world.

#### Phase 2 Acceptance Goals

Phase 2 should be judged against these goals:

1. **Warning clarity**
   The player should usually be able to see raider movement or receive a sighting notification before a serious attack if they invested in scouting, patrols, guard posts, or route visibility.

2. **Route pressure**
   Ashen Pass should feel faster and more dangerous. Old Pine Road should feel slower and safer. The player should understand that route choice changes exposure.

3. **Escort tradeoff**
   Assigning a squad to escort a shipment should feel useful, but costly. An escort protects the caravan, but that squad is then unavailable to guard the mine, scout, recover, or prepare for an assault.

4. **Mine stockpile pressure**
   Letting ore or supplies pile up at the mine should feel like an obvious vulnerability. The player should understand why raiders might attack an exposed local stockpile instead of waiting for a caravan.

5. **Supply-chain pressure**
   Raiders should threaten not only rare ore, but also the supplies that keep the mine and remote squads functioning. A lost supply shipment should create operational consequences, not just remove a number.

6. **Casualty consequences**
   Wounded and killed soldiers should feel connected to population, labor, workforce availability, and future capacity. A bad fight should matter beyond a temporary combat penalty.

7. **Material field discovery**
   Combat should create at least some strong material-learning moments. The player should be able to connect the field discovery to the equipment used and the combat context.

8. **Recovery after setback**
   A stolen shipment, wounded squad, damaged mine, or lost sample should usually be recoverable. Phase 2 should create adaptation problems before it creates hard failure.

9. **Fairness and legibility**
   Failure should feel like the result of visible risk, insufficient scouting, poor escorting, unsafe routing, exposed stockpiles, bad timing, or material uncertainty — not like the game arbitrarily stole resources.

10. **Future pull**
    The player should want deeper systems after playing Phase 2: better scouting, better equipment, trade, diplomacy, stealth, fortifications, specialists, and eventually tactical battles.

#### Required Phase 2 Test Scenarios

Phase 2 should be tested through several small scenarios, not only through one ideal path.

##### Test 1 — Unescorted Caravan Through Ashen Pass

Setup:

- Redglass ore shipment leaves the mine.
- Shipment uses the fast Ashen Pass route.
- No escort assigned.
- Raider party is active near the pass.

Questions:

- Does the player understand this is risky before the ambush?
- Does the ambush outcome feel fair?
- Is cargo loss explained clearly?
- Does the player understand how they could have reduced the risk?

Expected result:

> This should usually be dangerous. The player may get lucky, but an unescorted high-value shipment through the dangerous route should not feel safe.

##### Test 2 — Escorted Caravan Through Ashen Pass

Setup:

- Same route and cargo as Test 1.
- Player assigns an improvised militia or proper watch squad as escort.

Questions:

- Does the escort visibly attach to and move with the caravan?
- Does the escort materially improve the outcome?
- Does the player notice the opportunity cost of removing that squad from other duties?
- Are wounded/killed results displayed clearly if the escort suffers losses?

Expected result:

> The escort should usually improve the outcome, but may take casualties or become wounded/recovering.

##### Test 3 — Reroute Through Old Pine Road

Setup:

- Redglass shipment uses the slower Old Pine Road route.
- Raider presence is weaker or less immediate on that path.

Questions:

- Does the slower route feel meaningfully safer?
- Does the delay matter because the mine, forge, research, or future threat timing depends on delivery?
- Does the player understand why they might choose safety over speed?

Expected result:

> The player should feel that rerouting solved one problem while creating another: less danger, more delay.

##### Test 4 — Mine Stockpile Left Unguarded

Setup:

- Mine is active.
- Ore and/or supplies accumulate locally.
- No guard assigned.
- Shipments are delayed or paused.

Questions:

- Does the mine panel show the exposed stockpile clearly?
- Do raiders target the mine in a way that makes sense?
- Does the player understand that the mine was vulnerable because value sat there unprotected?

Expected result:

> A mine raid should feel like raiders exploiting an exposed physical opportunity, not like a random punishment.

##### Test 5 — Scout / Guard Post Warning

Setup:

- Player assigns a squad to scout Ashen Pass or establishes a temporary guard post.
- Raider party moves near the route or mine.

Questions:

- Does scouting reveal raiders earlier or with clearer information?
- Does the notification link to the correct map object?
- Does earlier warning create a real response window?

Expected result:

> Scouting should not fill a meter. It should reveal physical raider actors early enough to matter.

##### Test 6 — Late Mobilization

Setup:

- Raiders are spotted moving toward a shipment, mine, or route.
- Player attempts to raise improvised militia after the sighting.

Questions:

- Does mobilization take long enough that the warning window matters?
- Does late mobilization sometimes fail to arrive in time?
- Does the player understand that earlier preparation would have helped?

Expected result:

> Raising militia after a threat is spotted should be possible, but not instant. Warning creates opportunity, not guaranteed safety.

##### Test 7 — Redglass Armor / Shield Field Discovery

Setup:

- Player has forged Redglass armor or shields.
- Raiders use firepots, burning arrows, or another fire-exposure context.

Questions:

- Does the equipment affect the combat result?
- Does the field discovery feel tied to what happened?
- Does the Codex update make the material more strategically legible?

Expected result:

> The player should experience a clear discovery moment: the material's property mattered because the combat context exposed it.

##### Test 8 — Redglass Weapon Field Use

Setup:

- Player has forged Redglass weapons.
- Squad counterattacks raiders or assaults a raider party/camp.

Questions:

- Does weapon suitability affect the result?
- If the material is poorly suited to weapons, does that failure feel understandable after testing/field use?
- If it performs well, does the player understand why weapons are the strategic path for that material roll?

Expected result:

> Weapons should create a different strategic posture from armor/shields: more initiative, more risk, and stronger offensive resolution if the material supports it.

##### Test 9 — Bad Fight Population Consequences

Setup:

- Player loses a fight badly.
- Squad suffers wounded and killed results.

Questions:

- Does the result screen show returned ready, wounded/recovering, and killed clearly?
- Does Hearthmere's population/workforce update afterward?
- Does the loss reduce future labor or mobilization capacity in a visible way?

Expected result:

> Losing soldiers should feel like losing people, not merely losing a replaceable unit card.

#### Quantitative Tuning Targets

Exact numbers will change through testing. These targets describe desired feel.

| System | Desired Feel |
|---|---|
| **Unescorted high-value shipment through Ashen Pass** | Risky enough that players quickly learn escorts/scouting matter |
| **Escorted shipment through Ashen Pass** | Safer, but not guaranteed; casualties possible |
| **Old Pine Road route** | Safer enough to be tempting, slower enough to matter |
| **Improvised militia** | Can contest one basic raider group, but losses are likely |
| **Proper watch squad** | Favored against one basic raider group and capable of surviving repeated light pressure before rest/recovery |
| **Mine stockpile exposure** | Leaving value unguarded should become noticeably dangerous over time |
| **Wounded recovery** | Short enough to avoid death spirals, long enough to change immediate planning |
| **Killed population losses** | Rare enough that playtesters do not spiral instantly, severe enough that reckless fighting hurts |
| **Field discovery frequency** | Common enough to teach the loop, rare enough that it feels earned by relevant use |

#### Qualitative Playtest Questions

After a Phase 2 playtest, ask:

1. What did you think the raiders were trying to do?
2. Did you feel warned before the first serious attack?
3. What did you think your options were when raiders appeared?
4. Did route choice feel meaningful?
5. Did escorting feel worth the cost?
6. Did a mine stockpile or supply shipment feel like a real vulnerability?
7. Did casualties feel connected to Hearthmere's population and labor?
8. Did any material property reveal itself in a memorable way?
9. Did a setback make you want to adapt, or did it feel like the game wasted your time?
10. Did raiders make the Phase 1 loop more interesting?

#### Common Phase 2 Failure Modes

Watch for these problems:

- **Random punishment:** raiders attack without visible warning or understandable reason.
- **Invisible intent:** raiders are visible, but the player cannot infer what they threaten.
- **Escort tax:** escorting becomes mandatory busywork rather than a strategic tradeoff.
- **Route illusion:** fast and slow routes feel equivalent except for labels.
- **Stockpile irrelevance:** mine stockpiles do not create meaningful vulnerability.
- **Casualty abstraction:** killed/wounded results do not visibly affect population, workforce, or future decisions.
- **Combat detached from discovery:** battles happen, but material properties do not matter or reveal anything.
- **Death spiral too early:** one bad ambush ends the scenario without meaningful recovery options.
- **No escalation clarity:** the player cannot tell when the local threat is becoming severe enough to justify attacking the camp.
- **Too much interruption:** raiders constantly stop the player from using the economy rather than pressuring meaningful decisions.

#### Phase 2 Pass / Fail Standard

Phase 2 passes when the player can say:

> I saw raiders moving in the world. I understood what they threatened. I had ways to respond. The outcome changed cargo, people, routes, stockpiles, or knowledge in a way that made sense.

Phase 2 fails when the player says:

> The game randomly stole my stuff, and I do not know what I was supposed to do differently.

#### Acceptance Before Phase 3+ Expansion

Do not move into deeper raider AI, stealth, diplomacy, trade, specialists, or tactical battles until Phase 2 proves that the basic pressure layer works.

Phase 2 is ready to expand when:

- raider sightings are understandable,
- route choice affects outcomes,
- escorts matter without becoming mandatory every time,
- mine/supply stockpiles create natural vulnerabilities,
- combat results clearly affect people and resources,
- field discovery can occur from relevant combat contexts,
- and setbacks usually create adaptation rather than immediate failure.

Design principle:

> Add deeper raider behavior only after basic raider pressure is legible, fair, and strategically additive.



### 13.39 Phase 3 Local Security, Patrol, and Guard Post System

Phase 3 expands the player's ability to project control across the local map after raiders have been introduced. Phase 2 proves that raiders can threaten shipments, mines, and stockpiles. Phase 3 asks whether the player can respond in a more strategic way than simply escorting one caravan at a time or attacking raiders directly.

Phase 3's focus is **local security as a logistical commitment**.

The player should feel that securing territory requires people, supplies, time, visibility, and physical presence. A road is not safe because it lies inside the player's color on the map. A road is safer because scouts patrol it, guards watch it, caravans report activity, supply routes support those guards, and hostile actors have less freedom to operate there.

Design principle:

> Securing territory is an active logistical commitment, not a passive ownership state.

#### Phase 3 Purpose

Phase 3 should deepen the connection between the logistics economy and military/security decisions without requiring full tactical battles.

It should answer these questions:

- How does the player watch a dangerous route?
- How does the player protect a mine without escorting every single caravan?
- How does the player decide whether to guard Hearthmere, the mine, the fast route, or the slow route?
- How do remote security assignments consume supplies?
- How does the player see that a route is safer because someone is physically there?
- How does the game avoid using abstract security meters while still communicating useful information?

Phase 3 should make local control feel like a network of people and supplies, not a toggle.

#### Core Phase 3 Systems

Phase 3 introduces or deepens four connected systems:

1. **Guard posts** — stationary or semi-stationary security assignments that extend vision and response.
2. **Patrols** — moving security assignments along a route or between regions.
3. **Scouting assignments** — information-focused tasks that reveal prospects, route conditions, and hostile movement.
4. **Supply-supported remote presence** — guard posts and patrols consume supplies and can fail if not supported.

These systems should all use the same physical-world logic already established in Phase 1 and Phase 2.

People must come from Hearthmere's population and workforce. Supplies must be produced and moved. Squads and shipments must exist on the map. Threats should be visible, last-seen, or hidden based on actual vision.

#### Guard Posts

For the first implementation, a guard post should be a **temporary squad assignment**, not a permanent constructed building.

A squad assigned to establish a guard post anchors itself in a region or along a route. It remains visible on the map, consumes supplies, expands local vision, and can respond to nearby threats.

Prototype guard post behavior:

- requires a squad or labor/security team,
- takes a short setup time,
- consumes supplies while active,
- provides local vision,
- improves warning of raider movement,
- may participate in nearby mine raid or route ambush response,
- can be abandoned or recalled,
- becomes ineffective if undersupplied.

A guard post is not a magic safety aura. It does not make a route perfectly safe. It makes hostile movement more likely to be seen and gives friendly forces a physical response point.

Example use cases:

- establish a guard post at Ashen Pass to reveal raider parties earlier,
- establish a guard post near Redglass Foothills to protect the mine and stockpile,
- establish a guard post on Old Pine Road if the player shifts shipments to the safer route,
- abandon a guard post when supplies run low or the threat moves elsewhere.

Long-term, guard posts can become buildable structures with watchtowers, signal fires, roads, supply depots, barracks, specialists, and fortifications. For Phase 3, they should remain assignment-based so the player can learn the security logic before construction complexity is added.

Design rule:

> A guard post is a physical watch position staffed by people and fueled by supplies. It extends awareness and response, but it does not erase danger.

#### Patrols

A patrol is a squad assignment that moves repeatedly along a route or between a small set of connected regions.

Patrols differ from guard posts because they cover a path rather than one anchored point. They are better for route awareness and shipment protection, but they consume more supplies and may be out of position when a threat appears.

Prototype patrol behavior:

- assign a squad to a route or region pair,
- squad physically moves back and forth,
- patrol increases chances of spotting raiders along that path,
- patrol may deter or interrupt ambushes,
- patrol can respond to nearby caravan threats if close enough,
- patrol consumes supplies faster than stationary guard duty,
- patrol effectiveness depends on route length, squad speed, supply status, and visibility.

Example use cases:

- patrol Ashen Pass before sending a high-value ore shipment,
- patrol the route between Hearthmere and Redglass Foothills,
- patrol Old Pine Road if raiders shift toward the slower route,
- patrol near Westmere Farms to protect future supply production or refugee traffic.

A patrol should not produce a visible "security percentage" as the main player-facing output. Instead, the UI should show physical facts:

- which squad is patrolling,
- where it is currently located,
- what route it is covering,
- how long until it returns to a node,
- what sightings it has produced,
- whether it has enough supplies to continue.

Design rule:

> Patrols make routes safer because armed people are physically moving through them, not because a number went up.

#### Scouting Assignments

Scouting is information-focused. A scouting assignment may use a light squad, survey party, or future specialist. It should reveal what is already there rather than inventing abstract intelligence points.

Scouting can support three different player goals:

1. **Prospecting** — identify whether a prospect site is valuable, false, mundane, or low-yield.
2. **Route knowledge** — reveal danger, travel conditions, raider sightings, and unknown road state.
3. **Threat awareness** — spot raider scouts, camps, patrols, gathering parties, or last-known movement.

Scouting differs from patrolling because it is less about protection and more about knowledge. A scout may reveal danger before a caravan moves, but may not be able to stop the danger alone.

Prototype scouting behavior:

- assign a squad or survey party to scout a region, route, or prospect,
- scouting takes time,
- scouting expands known information,
- scouting may reveal raider map entities,
- scouting may update last-seen positions,
- scouting may uncover prospect quality,
- scouts may be forced to retreat if they encounter a stronger hostile force.

For Phase 3, scouting should not require a deep stealth system. It can operate through simple visibility ranges, route coverage, and scouting progress. Later versions can add stealth, detection, informants, rumors, bribery, false reports, tracking, concealment, and counter-scouting.

Design rule:

> Scouting turns uncertainty into actionable map information. It should reveal places, actors, routes, and opportunities, not fill an abstract intelligence bar.

#### Security Coverage Without a Gamey Meter

The player still needs to understand whether a route or region is protected, but the UI should avoid implying that safety is a passive meter.

Instead of showing:

```text
Ashen Pass Security: 73%
```

show grounded information:

```text
Ashen Pass
- Hearthmere Watch Squad patrolling route
- Last patrol passed 3 hours ago
- Raider scouts last seen near Blackbanner Camp 8 hours ago
- No current friendly guard post
- Next supply caravan ETA: 5 hours
```

Or:

```text
Redglass Foothills
- Mine active
- Mine stockpile: 14 Redglass Ore
- Guard post staffed by Improvised Militia
- Supplies remaining at post: 18 hours
- Raider party last seen moving toward Ashen Pass
```

The player-facing state should be made of facts. The game can internally calculate risk, detection chance, response time, and threat priority, but the player should experience these through visible actors and known information.

Useful player-facing descriptors:

- unscouted,
- recently scouted,
- patrol active,
- guard post active,
- no friendly presence,
- last hostile sighting,
- friendly squad nearby,
- supply low,
- route currently occupied by caravan,
- high-value cargo exposed.

Design rule:

> Communicate security through presence, sightings, supply status, and response time. Avoid making safety feel like a painted-zone stat.

#### Supply-Supported Security

Remote security should consume supplies. This is what keeps guard posts, patrols, and scouting from becoming free map coverage.

Minimum Phase 3 supply rules:

- guard posts consume supplies over time,
- patrols consume more supplies than stationary guard duty,
- scouts consume supplies while away from Hearthmere,
- remote squads can carry a small buffer,
- longer assignments require supply delivery or access to a local stockpile,
- undersupplied posts lose effectiveness, reduce sight range, or withdraw,
- raiders can target supply shipments supporting remote security.

This creates the intended AXIOM pressure:

> I can guard Ashen Pass, but can I keep that guard post supplied? If I send supplies there, do I need to escort the supply caravan? If I escort the supply caravan, what is not being guarded?

A security network should therefore become part of the logistics game. The player is not merely assigning guards. They are building and maintaining a fragile physical web of people, food, tools, and awareness.

#### Security Assignments and Commitment Capacity

Guard posts, patrols, and scouting assignments should use the same labor/manpower logic as the rest of the prototype.

A squad assigned to patrol cannot simultaneously escort a caravan. A squad staffing a guard post cannot attack the raider camp unless recalled. A scout surveying a prospect cannot also watch Ashen Pass.

Phase 3 should reinforce the existing commitment-capacity idea:

- Hearthmere can support only a limited number of simultaneous activities,
- each minor settlement or support site may eventually support one additional local commitment,
- supply throughput constrains how many remote commitments can operate at once,
- repeatedly shifting people between roles creates friction and lost efficiency.

The player should often face choices like:

- guard the mine or patrol the route,
- scout Blackbanner Camp or survey another prospect,
- escort this shipment or maintain the watch post,
- keep a squad at Hearthmere or push security outward,
- produce supplies or forge equipment,
- hold defensive posture or prepare a camp assault.

Design rule:

> The player should never have enough local security to cover everything perfectly. Choosing what remains exposed is the strategic decision.

#### Phase 3 Player Actions

Phase 3 should add or deepen these actions:

**On a squad:**

- assign to guard post,
- assign to patrol route,
- assign to scout region/route,
- recall from assignment,
- resupply / return to Hearthmere,
- intercept visible raiders if close enough.

**On a route:**

- inspect friendly presence,
- inspect last-known hostile sightings,
- assign patrol,
- assign route scouting,
- assign shipment escort,
- view active shipments and patrols.

**On a region:**

- establish temporary guard post,
- inspect local vision and sightings,
- assign scout,
- assign guard,
- inspect nearby stockpiles/facilities.

**On a guard post:**

- inspect staffed squad,
- inspect supply remaining,
- inspect sighting history,
- recall squad,
- request supply shipment,
- abandon post.

**On a shipment:**

- inspect whether route is patrolled,
- inspect nearby friendly/hostile presence,
- assign escort,
- delay departure until patrol passes or daylight returns,
- choose alternate route.

#### Phase 3 UX Flow

A simple Phase 3 flow might look like this:

1. The player has an active Redglass mine and recurring ore shipments.
2. Raiders are sighted near Ashen Pass.
3. The player clicks Ashen Pass and sees that no friendly squad is currently present.
4. The player assigns the Proper Watch Squad to patrol Ashen Pass.
5. The patrol consumes supplies and physically moves along the route.
6. A later sighting reveals a raider party shadowing the road.
7. The player delays the next shipment until the patrol is near the route midpoint.
8. The raider party either withdraws, attacks at worse odds, or shifts toward the mine.
9. The player considers establishing a guard post near Redglass Foothills, but realizes the post will require supplies.
10. The player must decide whether the security gain is worth the supply burden.

Desired player thought:

> I can make this route safer, but only by committing people and supplies that I need somewhere else.

#### Phase 3 Implementation Order

Phase 3 should be implemented in small layers:

1. **Patrol assignment without raider interaction**
   Squads can patrol a route and consume supplies while doing so.

2. **Guard post assignment**
   Squads can anchor in a region or route and provide local vision.

3. **Route/region presence UI**
   The route panel shows friendly squads, guard posts, patrols, and last-known sightings.

4. **Sightings from patrols/guard posts**
   Patrols and guard posts can reveal raider map entities within range.

5. **Ambush interaction**
   Patrols and guard posts can modify caravan ambush conditions if nearby.

6. **Supply-supported security**
   Guard posts and patrols consume supplies and degrade or withdraw when undersupplied.

7. **Security playtest pass**
   Test whether patrols/guard posts make logistics more interesting or merely add chores.

Do not add permanent forts, road construction, signal networks, advanced stealth, informants, or detailed terrain control until the temporary assignment version proves valuable.

#### Phase 3 Acceptance Criteria

Phase 3 succeeds if:

- the player understands how to make a route or mine safer,
- safety comes from visible friendly presence rather than abstract ownership,
- guard posts and patrols create meaningful opportunity costs,
- remote security consumes supplies and can be disrupted,
- scouting produces useful sightings without becoming a separate minigame,
- raider pressure feels more strategic because the player can shape the security network,
- and the player still cannot cover everything perfectly.

Phase 3 fails if:

- guard posts become free permanent safety zones,
- patrols require annoying micromanagement without meaningful decisions,
- the player must constantly babysit every route,
- security is communicated only through abstract percentages,
- remote supply support feels like busywork rather than strategic pressure,
- or raiders feel irrelevant because patrols solve them too completely.

The playtest question is:

> Does local security feel like a physical system of people, supplies, routes, and information — or just another layer of chores?

#### Long-Term Expansion

If Phase 3 works, it can later grow into:

- permanent watchtowers,
- road wardens,
- signal fires,
- forts,
- depots,
- supply stations,
- terrain control,
- stealth and detection values,
- counter-scouting,
- informants,
- bribed raiders,
- decoy caravans,
- patrol doctrines,
- specialists such as caravan captains and road wardens,
- regional security laws,
- and tactical battle positioning advantages.

Those systems should be added only after the temporary guard/patrol/scout model proves that securing physical space is interesting.

Final Phase 3 principle:

> Local security is the art of deciding where your limited people can see, stand, move, and be supplied. The map becomes yours only where you can actually project presence.


### 13.40 Phase 3 Implementation Checklist

Phase 3 turns the Phase 2 raider-pressure layer into a richer local security system. The goal is not to add full territorial control, permanent forts, stealth, or tactical battles yet. The goal is to let the player project limited presence into the world through squads, patrols, scouting assignments, temporary guard posts, and supply-supported remote security.

Phase 3 implementation rule:

> Build security as visible people doing visible jobs in specific places. Do not build abstract map ownership, invisible safety auras, or percentage-based security meters.

#### Phase 3 Minimum Success Statement

Phase 3 succeeds when the player can look at the map and understand:

- where they have actual friendly presence,
- where they are blind,
- which routes or sites are being watched,
- what supplies are required to maintain that presence,
- and what is left exposed because they cannot guard everything.

The player should be able to make a route or mine safer, but not free. Safety should cost manpower, time, supplies, and opportunity.

#### 1. Squad Assignment Expansion

Extend the squad assignment system so each mobile squad can be given one active assignment at a time.

Required assignments:

| Assignment | Purpose | Basic Behavior |
|---|---|---|
| **Guard Location** | Protect a settlement, mine, facility, or temporary post | Squad remains at or near the object and contributes to local defense/vision |
| **Escort Shipment** | Protect a caravan | Squad moves with the shipment and participates in any ambush resolver |
| **Patrol Route** | Watch a road/route over time | Squad moves along a route loop, revealing raiders and improving response chances |
| **Scout Area** | Improve local knowledge | Squad spends time revealing prospects, raiders, route conditions, or last-seen information |
| **Establish Temporary Guard Post** | Anchor presence away from Hearthmere | Squad becomes a static watch/security presence that consumes supplies |
| **Return / Resupply / Recover** | Bring squad back to safety | Squad travels to Hearthmere or another valid safe node |

Implementation tasks:

- Add assignment state to each squad.
- Add assignment target: region, route, shipment, mine, facility, or guard post.
- Add cancel/reassign behavior.
- Add hourly assignment processing.
- Prevent squads from accepting contradictory jobs at the same time.
- Make assignment changes create travel time if the squad is not already at the target.

Prototype simplification:

> A squad does not need multiple sub-orders. It needs one current job, one location, one supply state, and one visible map presence.

#### 2. Temporary Guard Posts

Temporary guard posts are the first version of projected local control. They are not permanent forts. They are a squad assignment that anchors soldiers in a place and gives the player better visibility and faster response in that area.

Required guard post behavior:

- Created by assigning an eligible squad to establish a post in a region or along a route.
- Takes a short setup time.
- Consumes supplies while active.
- Provides local vision.
- Improves response to nearby raider movement or attacks.
- Can be abandoned if the squad is recalled, defeated, undersupplied, or reassigned.
- Does not permanently change ownership of the region.

Minimum fields:

```text
Guard Post
- location_id
- assigned_squad_id
- setup_status: setting_up / active / abandoned
- supply_stockpile
- supply_consumption_per_day
- vision_range_or_adjacent_visibility
- local_response_modifier
```

Required UI:

- Region/route panel shows **Guard Post Present**.
- Guard post panel shows assigned squad, supplies remaining, visibility contribution, and abandon/recall action.
- Notifications warn when a guard post is low on supplies, sees raiders, or is forced to abandon.

Do not implement permanent towers, fortification upgrades, road forts, building trees, or garrison specialization yet. Those belong after the temporary assignment version proves useful.

#### 3. Patrol System

Patrols are moving security assignments. A patrol makes a route less blind, but it does not make the route perfectly safe.

Required patrol behavior:

- Squad is assigned to a route or small route loop.
- Squad moves back and forth along the route.
- Patrol can reveal raider entities earlier than passive vision.
- Patrol can influence caravan ambush context if close enough.
- Patrol consumes supplies faster than static guarding.
- Patrol may miss raiders if timing, visibility, night, or terrain conditions are unfavorable.

Minimum fields:

```text
Patrol Assignment
- squad_id
- route_id
- patrol_progress
- current_direction
- visibility_strength
- response_range
- supply_consumption_modifier
```

Required UI:

- Route panel shows **Patrolled by [Squad Name]**.
- Squad panel shows patrol route and supply remaining.
- Map shows the squad physically moving along the route.
- Sighting notifications fire when the patrol reveals raiders.

Design warning:

> Patrols should reduce uncertainty, not delete danger. A patrolled road is watched, not guaranteed safe.

#### 4. Scouting System Expansion

Scouting should remain information-first. It should not become an abstract intelligence currency.

Required scouting outputs:

- reveal or confirm prospect sites,
- update route knowledge,
- reveal visible raider entities,
- update last-seen raider information,
- identify whether a route has recent hostile movement,
- improve confidence in what the player knows about a region or road.

Minimum scouting behavior:

- A squad assigned to scout a region or route generates progress over time.
- Scouting updates the selected object with concrete findings.
- Scouting can fail to find anything meaningful if nothing is present.
- Scouting uses time and supplies.

Required UI:

- Region/route panel shows **Unscouted**, **Recently Scouted**, **Currently Scouted**, or **Outdated Information**.
- Scouting results create short notifications linked to the relevant map object.
- If a raider is spotted, the raider appears as a visible or last-seen map entity.

Avoid adding spy networks, informants, bribery, stealth ratings, false reports, or detailed detection math in Phase 3. Those can be added later on top of this object-based scouting model.

#### 5. Supply Support for Remote Security

Remote security must cost supplies. Otherwise guard posts and patrols become free safety coverage.

Required supply behavior:

- Squads have carried supplies.
- Guard posts may hold a small local supply stockpile.
- Patrols consume supplies while active.
- Guard posts consume supplies while active.
- Supply shipments can resupply guard posts or squads at valid locations.
- If supplies run out, the squad/post becomes strained, withdraws, or loses effectiveness.

Minimum supply failure states:

| State | Meaning | Effect |
|---|---|---|
| **Supplied** | Enough supplies available | Assignment functions normally |
| **Low Supplies** | Supplies nearly depleted | Warning notification; player can resupply or recall |
| **Out of Supplies** | Assignment cannot continue normally | Squad weakens, withdraws, or post is abandoned |

Required UI:

- Squad panel shows carried supplies and estimated remaining time.
- Guard post panel shows local supplies and estimated remaining time.
- Shipment panel supports supply deliveries to guard posts if implemented.
- Notifications warn before supply failure, not only after collapse.

Design rule:

> Remote security is part of the logistics game. If the player cannot supply a post, they cannot permanently project power there.

#### 6. Security Communication Without Meters

Do not communicate Phase 3 security as a clean numerical percentage. The player should understand security from physical facts.

Use labels like:

- **Unwatched**
- **Recently Scouted**
- **Patrolled**
- **Guard Post Present**
- **Escort Assigned**
- **Friendly Squad Nearby**
- **Raiders Last Seen Nearby**
- **Supply Low**
- **Out of Supply**
- **Information Outdated**

The route/region panel should show the objects responsible for the label. For example:

```text
Ashen Pass
Status: Patrolled
Friendly Presence: Hearthmere Watch Squad, currently on patrol
Known Threats: Blackbanner raiders last seen 5 hours ago near western ridge
Supply: Patrol has 14 hours of carried supplies remaining
```

This keeps the UI grounded in the world rather than presenting security as an abstract stat.

#### 7. Raider Interaction With Local Security

Raiders should respond to security presence, but security should not make them irrelevant.

Minimum raider/security interactions:

- Raiders may avoid strongly guarded routes and look for softer targets.
- Raiders may shadow a patrol without attacking.
- Raiders may attack an isolated guard post if it is weak or undersupplied.
- Raiders may still ambush a caravan on a patrolled route if timing or numbers favor them.
- A patrol near an ambush can improve the player's result or arrive as a modifier.
- A guard post near a mine can improve mine-raid defense or warning time.

Implementation shortcut:

> Raider decisions can remain simple. The important part is that player security changes raider opportunities and combat contexts.

Do not add sophisticated raider strategy, deception, long-term grudges, diplomacy, recruitment, or stealth infiltration yet.

#### 8. UI Panel Work

Phase 3 requires several panel additions.

Required panel updates:

**Squad Panel**

- current assignment
- assignment target
- carried supplies
- time until supplies run low
- buttons: Guard, Patrol, Scout, Establish Guard Post, Escort, Return, Cancel Assignment

**Region Panel**

- friendly presence
- guard post status
- scout state
- visible/last-seen raiders
- local supply points if any

**Route Panel**

- current patrols
- current shipments
- recent sightings
- route scouting state
- known friendly/hostile presence

**Guard Post Panel**

- assigned squad
- supplies remaining
- local vision/security effect
- recent sightings
- actions: resupply, recall squad, abandon post

**Notification/Event Log**

- raider sighted by patrol
- guard post low on supplies
- patrol lost contact
- raiders last seen moving toward route/mine
- guard post abandoned
- patrol joins/affects ambush

#### 9. Debug and Tuning Tools

Phase 3 should include debug tools because security systems are easy to make either useless or mandatory.

Useful debug controls:

- spawn raider party at selected region/route,
- reveal/hide raiders,
- set squad supplies,
- fast-forward patrol,
- toggle night/day,
- complete guard post setup,
- show internal visibility radius,
- show route/patrol assignment state,
- force caravan ambush near/away from patrol,
- simulate supply failure at guard post.

These should be developer tools, not player-facing systems.

#### 10. Phase 3 Cut Line

If Phase 3 scope gets too large, preserve these pieces first:

1. Squads can be assigned to patrol a route.
2. Patrols can reveal raiders earlier.
3. Squads can establish a temporary guard post.
4. Guard posts consume supplies.
5. Guard posts/patrols appear in region and route panels.
6. Security is communicated through visible presence, not percentages.

Cut or defer:

- permanent watchtowers,
- road construction,
- fort upgrades,
- stealth/detection math,
- informants,
- decoys,
- patrol doctrines,
- complex raider counterplay,
- specialists tied to security,
- regional law/order systems.

#### Phase 3 Completion Criteria

Phase 3 is ready for playtesting when:

- a squad can patrol a route and visibly move along it,
- a squad can establish a temporary guard post,
- both patrols and guard posts consume supplies,
- patrols and guard posts can reveal or update raider sightings,
- route/region panels show friendly presence and known threats,
- supply failure can weaken or end a remote security assignment,
- and at least one caravan ambush or mine raid can be affected by nearby patrol/guard-post presence.

The player-facing test is:

> Can I point to the map and explain where Hearthmere has eyes, where it has people, where it has supplies, and where it is still exposed?



### 13.41 Phase 3 Playtest Criteria and Tuning Targets

Phase 3 adds a new kind of strategic pressure: not just whether the player can move goods, discover materials, and respond to raiders, but whether the player can **project security into the world** without turning the map into passive ownership colors or security-percentage management.

The purpose of this playtest pass is to answer:

> Do guard posts, patrols, scouting assignments, and remote supply make local security feel physical, useful, and strategically costly rather than tedious?

Phase 3 should deepen the Phase 1–2 loop. It should not replace discovery/logistics with guard-post micromanagement.

#### Core Acceptance Goal

Phase 3 succeeds if the player can look at the map and understand:

- where they have real presence,
- where they are blind,
- what each squad is currently doing,
- what each remote security commitment costs,
- which routes or sites are protected,
- which routes or sites remain exposed,
- and how supply support limits how much territory can be safely covered.

The player should feel that security is a practical logistics problem:

> I can protect this road, mine, or pass, but only by assigning real people and keeping them supplied. Every protected place leaves some other place less protected.

#### Phase 3 Should Pass If...

A Phase 3 playtest should be considered successful if most of the following are true:

1. **Map presence is legible**  
   The player can quickly tell which regions/routes have friendly squads, patrols, guard posts, recent scouting, or no presence at all.

2. **Security feels physical**  
   Guard posts and patrols feel like people doing jobs in places, not like invisible safety modifiers.

3. **Patrols and guard posts feel meaningfully different**  
   A guard post feels like static presence and vision. A patrol feels like active route coverage and earlier contact along a road.

4. **Scouting remains valuable**  
   Scouting should reveal raiders, prospect information, route conditions, or last-seen movement earlier than passive waiting.

5. **Remote security has cost**  
   Guarding a mine, patrolling a route, or posting a squad away from Hearthmere should consume supplies, manpower, and assignment capacity.

6. **Supply support matters without becoming busywork**  
   A remote post running low on supplies should create a clear decision: resupply it, recall it, reduce activity, or accept degraded coverage.

7. **Raiders react believably**  
   Raiders should probe weak or exposed areas, avoid obviously strong presence when appropriate, and exploit blind spots without feeling omniscient.

8. **Overextension is understandable**  
   If the player tries to scout every region, guard the mine, patrol every route, escort every shipment, and prepare an attack, the failure should be obvious: not enough people, supplies, time, or squads.

9. **The system creates strategic triage**  
   The player should regularly ask: *Which route matters most right now? Which site can I afford to leave uncovered? Where do I need information more than defense?*

10. **The player wants better infrastructure later**  
   A successful Phase 3 should naturally make the player want roads, watchtowers, depots, professional scouts, specialists, better supply chains, and more permanent security systems.

#### Required Test Scenarios

Phase 3 should be tested with several controlled scenarios before expanding into deeper AI, stealth, diplomacy, or tactical battles.

##### Test 1 — Unwatched Route

Setup:
- The player sends an ore or supply shipment through a route with no scout, no patrol, and no guard post.
- Raiders are present somewhere nearby but not necessarily visible.

Expected result:
- The player has little or no warning before danger appears.
- If trouble occurs, it should feel like the route was genuinely unwatched, not like random punishment.

Questions:
- Did the player understand that no one was watching the road?
- Was the lack of warning believable?
- Did the player want to assign scouts/patrols next time?

##### Test 2 — Patrolled Route

Setup:
- The player assigns a squad to patrol Ashen Pass or another active route.
- Raiders move near or across the patrolled area.

Expected result:
- Raiders are spotted earlier or with better information.
- The patrol may deter, delay, intercept, or at least warn of danger.
- The route is safer, but not perfectly safe.

Questions:
- Did patrolling feel useful?
- Did the patrol's supply cost feel fair?
- Did the player understand what the patrol was covering?

##### Test 3 — Guard Post Near Mine

Setup:
- The player establishes a temporary guard post near the Redglass mine.
- The mine continues extracting and building a local stockpile.

Expected result:
- The mine has better local vision and faster response to raiders.
- The guard post consumes supplies and ties up a squad.
- The player sees the benefit and the cost.

Questions:
- Did the guard post make the mine feel meaningfully safer?
- Did the cost of maintaining the post matter?
- Did the player understand that the squad was unavailable elsewhere?

##### Test 4 — Supply Failure

Setup:
- A remote patrol or guard post runs low on supplies because the player forgets, delays, or loses a shipment.

Expected result:
- The post/patrol becomes strained, less effective, pauses, or withdraws depending on severity.
- The player receives clear, object-linked notifications.
- The failure reinforces the logistics fantasy rather than feeling like arbitrary decay.

Questions:
- Did the player know the post needed supplies?
- Did the warning arrive early enough to respond?
- Did the consequence make sense?

##### Test 5 — Overextension

Setup:
- The player tries to operate the mine, run research, forge equipment, patrol the fast route, scout the slow route, guard the mine, escort shipments, and prepare an attack with limited population/supplies.

Expected result:
- The economy visibly strains.
- Projects slow or pause.
- Supply pressure rises.
- Some areas remain uncovered.

Questions:
- Did the player understand why they could not do everything?
- Did the constraint feel like population/logistics reality rather than arbitrary cap design?
- Did specialization feel more efficient than perfectly balanced coverage?

##### Test 6 — Raider Adaptation

Setup:
- One route is well-patrolled while another route or stockpile remains weakly watched.
- Raiders evaluate possible targets.

Expected result:
- Raiders prefer exposed value or weaker presence where appropriate.
- They do not blindly attack the most guarded point unless desperate or much stronger.
- They also do not instantly know everything the player is doing.

Questions:
- Did raider behavior feel opportunistic rather than scripted?
- Did the player feel rewarded for visible security planning?
- Did raiders remain threatening without feeling omniscient?

#### Quantitative Tuning Targets

These values are starting targets only. They should be tuned based on playtest feel.

| System | Initial Target |
|---|---:|
| Temporary guard post setup time | 4–8 hours |
| Patrol assignment start time | 1–2 hours if squad is ready |
| Scout/visibility improvement from guard post | Noticeable within adjacent region/route |
| Patrol route cycle | Similar to normal squad travel time along that route |
| Guard post supply buffer | 1–2 days |
| Patrol carried supply buffer | 12–24 hours |
| Supply-low warning | At least 6–12 hours before failure |
| Remote security penalty when undersupplied | Reduced vision/response first, withdrawal later |
| Number of places Hearthmere can comfortably cover early | 1–2, not all |

The most important tuning rule is:

> Early Hearthmere should not be able to guard the mine, patrol both routes, scout all prospects, escort every shipment, and prepare an attack at the same time.

#### Qualitative Playtest Questions

Ask testers or evaluate internally using questions like:

- Did you understand where your squads were and what they were doing?
- Did guard posts and patrols feel different?
- Did you feel like security required real people and supplies?
- Did you ever feel forced into tedious guard coverage management?
- Did you understand why a route was safer or more dangerous?
- Did supply pressure make remote security more interesting or just annoying?
- Did raider sightings feel earned through vision and presence?
- Did you feel punished for not scouting, or informed by scouting?
- Did the map feel more alive after patrols and raiders were moving through it?
- Did you want more permanent infrastructure such as roads, watchtowers, depots, or trained scouts?

#### Common Failure Modes

Watch for these specific failures:

1. **Security becomes a chore**  
   If the player feels they must constantly babysit patrol routes and supply wagons, the system is too micro-heavy.

2. **Guard posts become invisible modifiers**  
   If the player forgets where their posts are or what they do, the system has become too abstract.

3. **Patrols feel mandatory everywhere**  
   If every route must be patrolled at all times, the system stops creating choices and becomes tax management.

4. **Raiders feel omniscient**  
   If raiders always hit the weakest point perfectly, the world feels unfair in the wrong way.

5. **Raiders feel stupid**  
   If raiders ignore obvious exposed value or suicide into protected routes repeatedly, pressure disappears.

6. **Supply upkeep becomes noise**  
   If remote supply warnings happen constantly without meaningful decisions, simplify buffers or reduce frequency.

7. **Map readability collapses**  
   If the player cannot tell what is guarded, scouted, patrolled, or blind, reduce simultaneous states and improve panels/icons.

#### Phase 3 Pass / Fail Standard

Phase 3 passes if the player can say:

> I know where my people are, what they are protecting, what it costs, and what I am leaving exposed.

Phase 3 fails if the player says:

> I am just dragging guards around to satisfy invisible safety rules.

The system should create security triage, not guard-duty busywork.

#### Acceptance Criteria Before Moving On

Before expanding into deeper tactical battles, stealth, permanent fortifications, diplomacy, or larger AI factions, Phase 3 should prove that:

- temporary guard posts are useful and understandable,
- patrols reveal or deter threats without guaranteeing safety,
- scouting creates better information before danger arrives,
- remote security depends on supply support,
- raider pressure responds to visible player presence,
- overextension is felt through real people and supplies,
- and the player can read the security state of the map without a percentage meter.

Once these are true, the game is ready for deeper security layers such as watchtowers, depots, roads, professional scouts, spies, stealth, informants, decoy caravans, and eventually tactical battles.

Design principle:

> Security should make the world feel more physical, not more bureaucratic. The player is not filling safety bars; they are deciding where Hearthmere's people physically stand watch.


### 13.42 Remaining Prototype Roadmap

The prototype should continue in phases rather than attempting to build the full fantasy at once. The first three phases establish the core: discovery/economy/logistics, raider pressure, and local security. The remaining phases should expand that foundation only where the next layer teaches something new about AXIOM.

Design principle:

> Every new phase should make the existing world model more meaningful. Do not add a system merely because it belongs in the eventual game; add it when it gives the player a new way to discover, protect, exploit, trade, or interpret the world.

#### Roadmap Summary

| Phase | Primary Purpose | Required for v0.1? |
|---|---|---|
| **Phase 1 — Discovery/Economy/Logistics** | Prove the non-combat material loop | Required first slice |
| **Phase 2 — Raider Pressure/Combat** | Make the Phase 1 economy vulnerable | Required for full v0.1 |
| **Phase 3 — Local Security** | Let the player project control through squads, patrols, and guard posts | Strongly recommended for full v0.1 |
| **Phase 4 — Material-Driven Combat Bridge** | Make combat reveal and exploit material properties | Required if v0.1 must prove field discovery |
| **Phase 5 — Trade/Value/External Actors** | Make non-military material value and specialization matter | Optional but highly valuable |
| **Phase 6 — Specialists/Facility Identity** | Add human texture and assignment tradeoffs without full character drama | Optional prototype expansion |
| **Phase 7 — World Pressure Hooks** | Add small Legacy/Divine/world-event signals without full grand AI | Stretch layer |
| **Phase 8 — Replayability/Proceduralization** | Replace handcrafted certainty with controlled variation | Stretch layer after the loop works |

The most important cutoff is between **Phase 4** and the later phases. A strong v0.1 should probably include Phases 1–4: the player discovers a material, builds a logistics chain, faces pressure, uses equipment in conflict, and learns something from field use. Phases 5–8 make the prototype richer, but they should not block the first complete validation of the core loop.

---

### 13.43 Phase 4 — Material-Driven Combat Bridge

Phase 4 exists to connect the abstract combat layer back to the core material-discovery fantasy. Phase 2 can prove that raiders threaten shipments. Phase 4 should prove that combat is not just a loss calculator; it is another way to learn what the world is made of.

Phase 4 should not attempt the full Final Fantasy Tactics-style battle system yet unless implementation is surprisingly cheap. It should be a **combat bridge**: abstract or semi-abstract combat that clearly accounts for material-derived weapons, armor, speed, supply, fire exposure, and field discovery.

Design principle:

> Combat should be a stress test for world knowledge. The player should learn from battle, not merely resolve battle.

#### Phase 4 Goals

Phase 4 should answer these questions:

- Does Redglass equipment change combat outcomes in a way the player can understand?
- Can field use reveal a property that research had not fully identified?
- Can the same material push different strategies in different runs?
- Does the player feel rewarded for testing, researching, and choosing equipment deliberately?
- Does combat make the Material Codex more useful rather than becoming a separate minigame?

#### Phase 4 Minimum Scope

Phase 4 should add or refine:

1. **Material-aware combat contexts**
   - caravan ambush,
   - mine raid,
   - settlement defense,
   - raider camp assault.

2. **Context tags**
   - fire exposure,
   - night attack,
   - rough terrain,
   - defensive position,
   - burdened caravan,
   - scouted enemy.

3. **Equipment effect application**
   - weapons affect attack,
   - armor/shields affect defense,
   - fire-resistant gear matters only when fire exposure exists,
   - weight/burden affects speed if that hook is implemented,
   - rushed/flawed gear can underperform if the material profile supports that behavior.

4. **Field discovery triggers**
   - equipment is used in a relevant context,
   - hidden property manifests,
   - discovery progress increases,
   - Codex entry updates after the battle.

5. **Combat result explanation**
   - why the result happened,
   - what material behavior mattered,
   - what was learned,
   - what remains unknown.

#### Implementation Checklist

- Add combat context tags to conflict reports.
- Add equipment-derived modifiers to the abstract combat resolver.
- Add material-property checks for each context tag.
- Add field-discovery progress from combat use.
- Add Codex update events from field discovery.
- Add result-screen sections for:
  - objective outcome,
  - casualties,
  - cargo/stockpile status,
  - equipment performance,
  - material field note,
  - strategic aftermath.
- Add at least two material variants that produce different combat lessons:
  - defensive/fire-hardened,
  - offensive/keen-edge.
- Add debug toggles to force combat contexts such as firebomb ambush or non-fire ambush.

#### Prototype Cut Line

Do not build full tactical battles yet unless the team can do so without delaying the core validation. Phase 4 can be abstract if it proves the loop.

Do not build:

- formations,
- elevation,
- action points,
- individual soldier turns,
- full morale,
- detailed injuries,
- spell lists,
- multi-unit tactical AI.

Those belong to the later tactical battle prototype.

#### Playtest Criteria

Phase 4 passes if the player says:

> I understand why this equipment mattered, and the fight taught me something about the material.

Phase 4 fails if the player says:

> Combat just added numbers and did not change how I think about discovery.

Required test scenarios:

1. Redglass shields used in a firebomb caravan ambush.
2. Redglass weapons used in a camp assault.
3. Rushed equipment underperforms because the material was poorly understood.
4. Researched equipment performs more reliably than rushed equipment.
5. A field discovery updates the Codex after combat.
6. A combat loss produces population and labor consequences.

Acceptance criteria before moving on:

- material properties can affect combat,
- combat can reveal material properties,
- combat results explain population consequences,
- the Codex becomes more useful after field use,
- and the player can identify at least one strategic change they would make next time based on what battle revealed.

---

### 13.44 Phase 5 — Trade, Value, and External Actors

Phase 5 should make **Value / Appeal** matter. If some materials are not militarily useful but are still valuable, the game needs at least one external actor who wants them. This phase should also begin to express the long-term idea that specialization creates trade reasons.

This should not become a full diplomacy or market simulation yet. It only needs to prove that a discovered material can matter because someone else values it.

Design principle:

> Not every useful discovery is a weapon. Some discoveries become leverage, wealth, obligation, temptation, or danger because other people want them.

#### Phase 5 Goals

Phase 5 should answer:

- Can a high-value, low-military material still feel strategically important?
- Does trade give the player a reason to specialize rather than self-produce everything?
- Can external demand create pressure without immediately becoming war?
- Can material knowledge become bargaining power?

#### Minimum Scope

Add one or two simple external actors:

1. **Traveling Merchant / Caravan Factor**
   - buys valuable material samples or ore,
   - sells supplies or basic equipment,
   - appears on a schedule or route.

2. **Neighboring Settlement / Westmere Farms**
   - trades supplies for ore, protection, or equipment,
   - may provide additional supply production or labor support,
   - gives a first reason to secure routes beyond Hearthmere.

Optional third actor:

3. **Scholar Envoy / Academy Patron**
   - wants samples,
   - can accelerate research,
   - may pay in knowledge instead of coin.

#### Trade Model for Prototype

Keep trade concrete and local.

Allowed Phase 5 trade outputs:

- supplies,
- basic weapons,
- basic armor/shields,
- labor support event,
- research progress,
- route access,
- one-time specialist visit,
- coin only if a spending loop already exists.

Avoid a full market. A trade should be a clear exchange:

```text
Deliver 10 Redglass Ore to Westmere Farms.
Receive 30 Supplies over the next 2 days.
```

or:

```text
Give Redglass sample to Scholar Envoy.
Gain +40% analysis progress on Redglass.
```

#### Implementation Checklist

- Add external actor object or simple event actor.
- Add trade-offer data:
  - desired good,
  - quantity,
  - destination,
  - reward,
  - expiration window if any.
- Add physical delivery requirement for material trades.
- Add trade route/shipment support using existing logistics systems.
- Add Value / Appeal material property to trade valuation.
- Add event log and summary entries for completed trades.
- Add at least one high-value/low-military material variant.

#### UX Requirements

The player should see trade as a world opportunity, not a shop menu.

Good UX examples:

- Merchant caravan appears on Old Pine Road.
- Westmere Farms requests protection or supplies.
- Scholar envoy arrives at Hearthmere asking for a sample.
- Notification links to the actor or destination.
- Trade requires physical shipment.

Avoid:

- global instant marketplace,
- invisible sale button,
- universal price list,
- abstract trade income detached from routes.

#### Playtest Criteria

Phase 5 passes if a player can say:

> This material was not great for weapons, but it still changed my strategy because someone wanted it.

Phase 5 fails if trade feels like:

> I clicked sell and got money.

Required test scenarios:

1. High-value/low-military material appears.
2. Player chooses between forging, researching, and trading it.
3. Player physically ships material to complete a trade.
4. Trade reward changes the next decision, such as enabling supplies, equipment, or research.
5. Route risk or opportunity cost makes the trade non-trivial.

Cut line:

Do not build full diplomacy, prices, markets, taxes, trade agreements, supply/demand curves, or merchant AI. Phase 5 only needs material value to create one concrete external opportunity.

---

### 13.45 Phase 6 — Specialists, Facility Identity, and Labor Continuity

Phase 6 should add human texture without opening the full CK3-style character layer. The goal is to make facilities and assignments feel less generic and to create sharper tradeoffs around expertise.

Design principle:

> Specialists are not stat sticks. They are scarce people whose placement creates opportunity, vulnerability, and attachment.

#### Phase 6 Goals

Phase 6 should answer:

- Does assigning a specialist create an interesting tradeoff?
- Does a forge, academy, caravan route, or mine feel more distinct when a named person is involved?
- Does exposing a specialist to frontier danger create tension?
- Does labor continuity matter without becoming micromanagement?

#### Minimum Specialist Types

Use one or two specialists only.

Recommended starting specialists:

1. **Master Smith**
   - improves forge reliability,
   - reduces rushed-forging risk,
   - may reveal workability issues faster.

2. **Field Scholar / Surveyor**
   - improves prospect surveying,
   - improves practical testing or academy analysis,
   - may interpret material clues better.

Optional later specialist:

3. **Caravan Captain / Road Warden**
   - improves shipment speed or safety,
   - improves route scouting,
   - reduces supply loss.

#### Specialist Assignment Rules

- One specialist can be assigned to one major responsibility at a time.
- Reassignment takes time if the specialist must travel.
- Specialists are physical or semi-physical assets.
- Specialists assigned to exposed locations can be threatened in later phases.
- Specialist bonuses should improve reliability or information, not replace systems.

Good specialist effects:

- reduce project time,
- reduce flawed-output chance,
- improve discovery progress,
- reveal a warning earlier,
- increase output quality modestly,
- reduce supply waste.

Bad specialist effects:

- flat huge bonuses,
- mandatory optimal picks,
- invisible global buffs,
- too many character stats.

#### Labor Continuity Expansion

Phase 6 can lightly expand the labor-continuity idea:

- labor teams assigned to the same job for several days gain a small efficiency state,
- pulling them away removes or pauses that continuity,
- emergency reassignment remains possible but has an opportunity cost.

This should remain simple. The goal is to prevent perfectly frictionless role swapping, not to create worker-management busywork.

#### Implementation Checklist

- Add specialist object:
  - name,
  - role,
  - current assignment,
  - location,
  - simple effect,
  - availability state.
- Add specialist slot to forge, academy, survey, route, or mine.
- Add reassignment time.
- Add specialist effect display in project panel.
- Add one event/result where specialist assignment changes the outcome.
- Add debug control to move or assign specialists quickly.

#### Playtest Criteria

Phase 6 passes if the player says:

> I wanted the specialist in two places and had to choose.

Phase 6 fails if the player says:

> I just put the specialist in the obvious slot and forgot about them.

Required test scenarios:

1. Master Smith improves a difficult forge project.
2. Field Scholar speeds up or clarifies material discovery.
3. Specialist assignment creates a conflict with another priority.
4. Reassignment delay matters at least once.
5. Specialist exposure or absence changes player planning.

Cut line:

Do not build families, relationships, salaries, loyalty, assassination, marriage, inheritance, or character drama yet. Specialists are the first bridge toward that layer, not the full layer.

---

### 13.46 Phase 7 — World Pressure Hooks: Legacy Border, Deity Flavor, and Event Windows

Phase 7 should add a small taste of the larger AXIOM world without requiring full Legacy Empire AI, divine systems, or grand diplomacy. The goal is tone plus strategic windows.

Design principle:

> The world should feel larger than the prototype, but the larger world should not steal focus from the local discovery loop.

#### Phase 7 Goals

Phase 7 should answer:

- Can the player feel that Hearthmere exists in a wider asymmetric world?
- Can world events create temporary opportunities or risks?
- Can Legacy and divine flavor reinforce replayability without demanding full systems?
- Can these hooks modify the local scenario without becoming random noise?

#### Minimum Hooks

Add one or two per run, not all at once.

Possible hooks:

1. **Silent Border Patrol**
   - a distant Legacy Empire patrol appears near the border,
   - does not attack,
   - changes route caution or creates flavor pressure.

2. **Deity Omen**
   - a local god's mood affects weather, prospecting, research, or supplies,
   - communicated through event text and a simple modifier.

3. **Weather / Seasonal Window**
   - rain slows routes,
   - dry wind increases fire exposure risk,
   - clear weather improves survey speed,
   - drought increases supply pressure.

4. **Ancient Relic Rumor**
   - a prospect or ruin event hints at a non-material objective,
   - may become a later alternate victory path.

5. **Refugee / Captive Event**
   - population can change through concrete world events,
   - reinforces the population model.

#### Implementation Checklist

- Add simple scenario modifier object.
- Add event-window data:
  - name,
  - duration,
  - affected systems,
  - visible explanation,
  - optional map location.
- Add one Legacy-border flavor event.
- Add one weather/divine/local event that changes a Phase 1–3 system.
- Add UI presentation as world event, not abstract modifier list.
- Add event summary in scenario end screen.

#### Playtest Criteria

Phase 7 passes if the player says:

> That event changed my plan and made the world feel larger.

Phase 7 fails if the player says:

> Random stuff happened and I could not tell why it mattered.

Required test scenarios:

1. Weather affects route/shipment timing.
2. Divine/local omen affects research, supplies, or fire exposure.
3. Legacy-border signal creates tension without forcing engagement.
4. Event window creates a temporary strategic opportunity.
5. Scenario summary mentions how the world hook affected the run.

Cut line:

Do not build full gods, cult growth, diplomacy, Legacy Empire arcs, or world-scale event chains yet. Phase 7 is a hook layer, not the complete world simulation.

---

### 13.47 Phase 8 — Replayability and Controlled Proceduralization

Phase 8 should replace handcrafted certainty with controlled variation once the loop is readable. Proceduralization should come after the player understands the systems, not before.

Design principle:

> Randomness should create new reasoning problems, not unreadable noise.

#### Phase 8 Goals

Phase 8 should answer:

- Can the same prototype scenario produce meaningfully different strategies?
- Can material variation change player decisions without feeling arbitrary?
- Can prospect layout, route risk, and raider posture vary while remaining readable?
- Does replay make the player investigate rather than memorize?

#### Systems to Randomize First

Randomize in this order:

1. **Material Variant Roll**
   - defensive/fire-hardened,
   - offensive/keen-edge,
   - high-value/low-military,
   - volatile/research-favored.

2. **True Prospect Location**
   - Redglass deposit appears at one of several prospect sites.

3. **Poor/False Prospect Outcomes**
   - mundane stone,
   - low-yield ore,
   - exhausted seam,
   - valuable but non-military material.

4. **Route Pressure**
   - Ashen Pass usually risky,
   - Old Pine Road usually slower/safer,
   - exact raider visibility and route activity vary.

5. **Raider Posture**
   - aggressive caravan raiders,
   - mine thieves,
   - cautious scouts,
   - opportunistic but weak camp.

6. **World Hook**
   - weather,
   - omen,
   - border signal,
   - refugee/captive opportunity.

Do not randomize everything at once. Add one random axis and retest readability.

#### Implementation Checklist

- Add scenario seed.
- Add material variant selector.
- Add prospect outcome generator from a controlled table.
- Add route-risk/posture variation.
- Add optional world hook selector.
- Add debug display for generated values.
- Add replay/reset button that generates a new run.
- Add scenario summary that reports what was generated and what the player discovered.

#### Playtest Criteria

Phase 8 passes if the player says:

> I cannot assume the same answer will work next time, but I understand how to investigate.

Phase 8 fails if the player says:

> The game is random, so planning does not matter.

Required test scenarios:

1. Same map, different material variant changes equipment choice.
2. Different true prospect location changes opening priority.
3. Different route pressure changes shipment plan.
4. Different raider posture changes security plan.
5. Different world hook changes timing or risk.
6. Player can explain after the run what they learned and why they adapted.

Cut line:

Do not build full procedural world generation yet. Phase 8 is controlled scenario variation, not the entire world generator.

---

### 13.48 Tactical Battle Prototype Trigger

The long-term tactical battle system should begin only after the strategic layer creates conflicts worth resolving. AXIOM should not build tactical battles simply because tactical battles are part of the dream. They should be added when the player already cares about the caravan, squad, material, cargo, route, and people involved.

Design principle:

> Tactical battles are the zoomed-in expression of strategic commitments already made on the map.

#### When to Start Tactical Battle Prototyping

Begin tactical battle prototyping when all of these are true:

- squads exist as physical map actors,
- shipments and cargo matter,
- equipment choice matters,
- casualties affect population/workforce,
- field discovery from combat matters,
- raider pressure creates meaningful conflicts,
- and the player wants to see how the fight actually plays out.

If those conditions are not true, tactical battles will likely feel disconnected.

#### First Tactical Battle Test

The first tactical battle should be a small caravan interception:

- one player escort squad,
- one caravan/cargo objective,
- one raider group,
- small grid,
- two elevation levels if feasible,
- simple win/loss/cargo outcomes,
- one material interaction such as fire-resistant shields or sharp Redglass weapons.

The tactical test should return results to the strategic map:

- cargo delivered, stolen, or abandoned,
- casualties killed/wounded/returned,
- equipment performance note,
- field discovery progress,
- raider strength reduced or intact,
- route confidence updated.

#### Tactical Prototype Cut Line

Do not start with:

- full class system,
- deep ability trees,
- large battles,
- many unit types,
- magic schools,
- full AI personalities,
- long-term veterancy,
- equipment durability,
- morale simulation,
- 3D terrain.

Start with a single tactical proof:

> Can a small battle make the player's prior strategic choices feel visible and consequential?

---

### 13.49 Prototype Completion Definition

The prototype should eventually be considered complete enough to pause design expansion when it proves the core AXIOM loop from end to end.

Prototype completion does not mean the game is feature-complete. It means the team has enough evidence to decide whether the concept is worth building further.

#### Full Prototype Success Statement

The full prototype succeeds if the player can say:

> I investigated an uncertain world, found a strange material, built a vulnerable logistics chain around it, learned what it could do, adapted my strategy, protected or exploited the chain under pressure, and ended the scenario wanting to try another world.

#### Required Full Prototype Capabilities

A full v0.1 prototype should include:

- known local starting situation,
- multiple prospect sites,
- at least one valuable material discovery,
- local population/workforce/labor teams,
- supplies as physical goods,
- local stockpiles and no global inventory,
- time-based projects,
- material Codex updates,
- mine setup and supply consumption,
- physical shipments,
- weapons/armor/research material fork,
- squad mobilization from population,
- raider pressure as visible world actors,
- caravan ambush combat resolver,
- casualty results with killed/wounded/returned,
- at least one field discovery from combat,
- one local victory path,
- one clear defeat path,
- scenario summary.

#### Strong Optional Capabilities

These should be added only if the core loop already works:

- mine raid resolver,
- settlement defense resolver,
- camp assault resolver,
- temporary guard posts,
- patrols,
- trade/value actor,
- one specialist,
- one world hook,
- controlled replay randomization.

#### Stop Adding Features When...

Stop expanding the prototype and start testing/tuning when:

- the player can complete a full discovery-to-conflict loop,
- at least two material variants produce different strategies,
- logistics feel physical,
- population losses feel meaningful,
- raider pressure feels fair,
- the Codex matters,
- and the scenario has a satisfying end summary.

Feature expansion should pause before the prototype becomes a half-built full game.

#### Final Prototype Design Principle

> The prototype is not trying to prove every future system. It is trying to prove that discovery, logistics, population, and pressure can combine into a strategy game where every world asks the player to think differently.



### 13.50 Updated v0.1 Build Scope

**Map:** Seven-region handcrafted region-node graph: Hearthmere, Redglass Foothills, Ashen Pass, Old Pine Road, Westmere Farms, Blackbanner Camp, and The Silent Border. Organic visual terrain, route-based movement, no visible hex grid. The map should contain multiple prospect opportunities inside or between regions, not one obviously correct mine marker.

**Factions:** One player faction, one local raider actor, one distant Legacy Empire border presence. For the full v0.1 scenario, the raider band does not need full strategic AI; it only needs enough behavior to notice exposed ore value, watch routes, raid mine stockpiles, intercept caravans, or steal samples from the discovered ore site. For the first implementation slice, active raiders may be omitted entirely so the discovery/economy/logistics loop can be tested without AI or combat.

**Starting situation:** The player begins with basic knowledge of the local area rather than a blank map. Nearby regions, major routes, several prospect opportunities, Hearthmere, and at least one known danger area should be visible from the start. The first decision is how to prioritize discovery, security, route knowledge, and preparation.

**Starting assets:** The player starts with Hearthmere, basic knowledge of nearby regions, several visible prospect leads, a total population, an available workforce represented through labor teams, Hearthmere supply production, a small local supply stockpile, and basic Forge/Academy access. Current v0.1 direction: starting field squads = 0, spare armory stockpiles = 0, and coin/liquid value = 0 or omitted unless a spending loop is implemented. Hearthmere has an abstract local defense value so the capital is not defenseless, but mobile military power must be created through non-instant mobilization projects that assign real manpower, supplies, and equipment. Improvised militia can be raised relatively quickly, but not instantly; proper watch squads take longer. Soldiers killed in combat permanently reduce the population/workforce base for the scenario; wounded soldiers temporarily enter recovery. No passive birth-based population growth is needed for v0.1, though refugees, rescued captives, or returning missing workers may increase population through concrete events.

**Prospecting:** The prototype should include several prospect sites. At least one becomes the true Redglass deposit after survey; at least one should be mundane, low-yield, false, or exhausted. Prospecting should use scouts/prospectors or a survey assignment and create opportunity cost before the extraction chain begins.

**Logistics chain:** Prospect Site → Survey → Deposit → Extraction Site → Local Stockpile → Caravan Route → Workshop/Forge or Research Site → Output → Destination. No global inventory. Supplies also move physically, especially from Hearthmere to the mine or to remote squads/guard posts.

**Discovery:** Tier 1 immediate observation, Tier 2 practical testing, and one simple Tier 3 academy analysis. Field discovery appears through combat/result notifications and Codex updates after equipment is used. The first material should use a scoped prototype attribute set: weapon suitability, armor/shield suitability, thermal response, weight/burden, workability, value/appeal, and one simple magical modifier only if it maps to an implemented stat. The Codex may state discovered effects explicitly for v0.1.

**Equipment fork:** The first scarce ore batch can be committed to weapons, armor, or research delay. Weapons and armor should produce different strategic postures because of the material's generated physical sliders, elemental responses, equipment form, crafting process, battle context, and delayed magical behavior, not because of fixed hard-coded bonuses.

**Staffing:** Settlement labor pools with broad priority sliders. One specialist slot per major facility, or one starting specialist who can improve either forging, testing, research, or caravan safety.

**Threat/pressure:** In the full v0.1 scenario, ore discovery creates a local opportunity that raiders may respond to. The player is pressured to claim, extract, move, study, and use the ore before raiders interfere. Raiders primarily threaten ore caravans, mine stockpiles, and exposed supply shipments that keep the mine or remote squads functioning. They should appear as hidden, partially revealed, or visible map entities depending on player scouting and local vision. In the first implementation slice, pressure can come only from scarcity, labor limits, supply throughput, project timing, route distance, and material uncertainty; raiders are added in later phases.

**Counterplay:** In the full v0.1 scenario, the player can guard, scout, assign squads, establish temporary guard posts, escort caravans, move directly, or reduce exposed activity. Raider pressure should be represented through visible or discoverable raider map entities rather than a player-facing attention meter. Mining, stockpiling, shipping, and forging rare ore create opportunities that raiders may respond to. Scouting, patrols, watchposts, escorts, smaller shipments, paused extraction, and alternate routes help the player see or manage that danger. In the first implementation slice, these actions can exist as preparation/logistics tools even if no raiders are active yet.

**Opening flow:** The first 10 minutes should move the player through prospecting, discovery, claim, extraction posture, first shipment, and first ore commitment. The player should inspect multiple prospect opportunities, survey at least one site, discover the strange material, claim the valuable deposit, choose a cautious or aggressive extraction posture, move ore through a physical route, and then commit the first batch to weapons, armor, or research/testing.

**UI/actions:** The prototype interaction model should be based on physical decision surfaces: map objects, settlements, facilities, prospect sites, deposits/mines, routes, caravans, squads, raiders, material entries, equipment projects, and notifications. Each surface should have a small context panel with local information and context-specific actions. Owned squads should support both direct movement and assignment-based behavior: guard, escort, scout, patrol, or establish a temporary guard post. Owned objects offer direct control; neutral and hostile objects usually offer inspection, scouting, avoidance, interception, or attack. Notifications summarize changes and jump back to world objects; they should not replace the map as the source of truth.

**Coalition AI:** Out of scope for the first playable prototype unless represented as a simple event or future-facing hint.

**Real-time/time model:** Continuous with pause and speed controls, driven by an hourly simulation tick. The UI may summarize projects in days, but movement, visibility, supplies, scouting, raider behavior, caravan travel, and future day/night mechanics should be able to resolve at the hourly level. Crisis events auto-slow to minimum speed. The real-time hook should come from waiting for samples, caravans, tests, and threats to resolve.

**Combat:** Combat is not required for the first implementation slice. The initial build can stop after the player discovers, mines, ships, studies, and forges the material. For the full v0.1 scenario, combat should use an abstract result screen unless a small tactical test is cheap to implement. Squads need only simple Attack, Defense, Condition, Assignment, Manpower, Supply Use, Movement Speed, and Equipment Coverage values. Combat must support objective-based context resolvers for caravan ambushes, mine raids, settlement defense, raider skirmishes, camp assaults, and field discovery. Combat results should separate returned ready survivors, wounded/recovering survivors, and killed people so population and workforce consequences are clear. Caravan ambushes should be the first resolver implemented because they connect logistics, speed, escorts, cargo, supplies, raider pressure, casualties, and material field discovery.

**Scenario endings:** The full v0.1 scenario should support at least one clear military victory, one defensive/logistics victory if feasible, and one clear defeat condition. The primary military victory is clearing or dispersing Blackbanner Camp. A secondary victory can be securing the Redglass ore chain through a major raider threat. The primary defeat condition is Hearthmere being sacked after its defenses fail. Smaller failures such as lost caravans, stolen samples, bad material choices, and mine raids should usually be recoverable setbacks. For the first no-raider implementation slice, the completion condition can simply be successful material discovery and first meaningful material application.

**The test:** The first implementation test is non-combat: one settlement, multiple prospect sites, one strange ore deposit discovered through survey, one mine that consumes supplies, at least one supply shipment, two route choices, one forge/workshop, one academy or research action, one material application fork, and a completion state that tests whether discovery can become strategy. The full v0.1 test then adds a Hearthmere squad-creation flow for improvised militia and proper watch squads, the ability to create at least one mobile militia/guard squad with manpower, supply use, movement, assignments, and equipment coverage, one local raider actor capable of contesting the ore chain, and scenario endings that test whether the discovery/logistics loop survives pressure. If the player feels curiosity, scarcity, pressure, and adaptation from that scenario, the foundation works.

### 13.51 Remaining Decisions and Handoff Notes

The design now has a complete prototype roadmap from Phase 1 through controlled replayability and the tactical-battle trigger. The remaining unresolved questions should be treated as handoff notes rather than blockers.

Remaining decisions that may require user/designer input later:

1. **Exact starting numbers** for Hearthmere's population, available workforce, labor team size, supply stockpile, supply production, and settlement defense.
2. **Phase 1 completion condition** for the no-raider slice: first ore delivery, first property discovered, first meaningful material output, or all three.
3. **One final example Codex reveal sequence** for a non-combat-relevant Redglass roll.
4. **Initial tuning values** for improvised militia, proper watch squad, supply use, and equipment coverage once raiders are implemented.
5. **Required versus stretch victory paths** for the full v0.1 scenario.
6. **Which phase marks the first public/internal demo target**: Phase 1 no-combat loop, Phase 2 caravan ambush, Phase 4 material-driven combat bridge, or Phase 8 controlled replayability.

Recommended handoff order:

1. Build Phase 1 from the technical architecture and checklist.
2. Playtest Phase 1 until the non-combat loop is legible.
3. Add Phase 2 raider pressure only after logistics and discovery are understood.
4. Add Phase 3 local security if raider pressure needs richer counterplay.
5. Add Phase 4 material-driven combat if field discovery needs stronger proof.
6. Treat Phases 5–8 as expansion layers once the central loop is already working.

*Recommended next session: switch from GDD expansion to either Phase 1 implementation planning, a task tracker/issue list, a data-schema sketch, or a clickable-paper-prototype script.*


### 13.52 Solo Developer Execution Plan

The prototype roadmap is now large enough that the next risk is not missing design ideas; it is trying to build too much at once. This section reframes the prototype for a one-person developer with limited game-design experience.

The goal is not to build AXIOM as imagined. The goal is to build the smallest playable version that proves the foundation:

> A player can inspect a known local world, discover an uncertain material opportunity, commit finite people and supplies, move physical goods through routes, learn properties through testing, and produce a meaningful output.

If that loop does not work, raiders, tactical battles, deities, trade, and Legacy Empires will not save it. If that loop does work, the later systems have something real to pressure and enrich.

#### Solo Developer Rule

> Build one hard-coded scenario first. Do not build the game generator, final economy, final combat system, or final UI architecture before the first loop is playable.

The first implementation should be a graybox prototype. It can use placeholder icons, simple panels, text buttons, debug tools, and hard-coded data. It should feel more like an interactive systems test than a finished game.

Do not spend early effort on:

- procedural map generation,
- tactical battles,
- polished art,
- animation,
- final balance,
- full AI,
- multiple factions,
- diplomacy,
- deities,
- trade systems,
- specialists,
- multiple material families,
- or final database architecture.

Spend early effort on:

- clicking world objects,
- seeing local stockpiles,
- assigning labor teams,
- advancing time,
- watching projects complete,
- moving supplies and ore physically,
- updating the Codex,
- and completing the first material output.

#### First Build Target

The first build target is not the full v0.1 prototype. It is **Phase 1A: The Non-Combat Discovery/Logistics Loop**.

Phase 1A is complete when the player can:

1. inspect Hearthmere and nearby prospect sites,
2. assign labor to survey one prospect,
3. advance hourly time until the survey completes,
4. reveal a useful material deposit,
5. claim the deposit,
6. establish a basic mine,
7. send supplies to the mine,
8. mine ore into a local mine stockpile,
9. ship ore from the mine to Hearthmere,
10. run one material test or academy analysis,
11. update the Codex,
12. choose one material output,
13. complete the output,
14. and see a summary of what was discovered, moved, spent, and built.

No raiders are required. No combat is required. No squads are required unless they are cheap to mock as future-facing placeholders.

#### Build Order for a Solo Developer

The safest order is to build from stable foundations upward. Each milestone should produce something clickable and testable before moving on.

##### Milestone 0 — Project Skeleton and Scenario Data

Purpose: create a place where the prototype can load one hard-coded scenario.

Build tasks:

- Create the project/repository.
- Create one hard-coded scenario file or data object.
- Define Hearthmere, nearby regions, routes, and prospect sites in data.
- Define one or two material variants in data.
- Add a basic app/game shell with pause/play state.
- Add a debug reset button.

Do not build procedural generation. Do not build a save system yet unless it is trivial.

Minimum test:

> The prototype boots into one known scenario and can reset to its starting state.

##### Milestone 1 — Clickable Map and Inspection Panels

Purpose: make the world inspectable before it is simulated.

Build tasks:

- Render the seven-region graybox map.
- Show Hearthmere, prospect sites, and routes.
- Make regions clickable.
- Make prospect sites clickable.
- Make Hearthmere clickable.
- Add a right-side or bottom selection panel.
- Show object name, type, known state, and available actions.
- Add an event log panel.

Minimum test:

> The player can click Hearthmere, a route, and a prospect site and understand what each object is.

##### Milestone 2 — Time, Projects, and Event Log

Purpose: make actions take time.

Build tasks:

- Add current day/hour.
- Add pause/play/speed controls.
- Add hourly tick advancement.
- Add a generic project system.
- Projects should have owner object, type, remaining hours, required labor teams, and completion effect.
- Add event log notifications when projects start and complete.
- Add debug buttons: advance 1 hour, advance 12 hours, complete selected project.

Minimum test:

> The player can start a dummy project, advance time, and see it complete with an event log entry.

##### Milestone 3 — Hearthmere Economy Foundation

Purpose: make population, labor, and supplies concrete enough to constrain choices.

Build tasks:

- Add Hearthmere population values.
- Add available workforce.
- Convert available workforce into labor teams.
- Add a local Hearthmere supply stockpile.
- Add supply production as a project or labor assignment.
- Make labor teams unavailable while assigned to active projects.
- Make projects pause or fail to start if labor is unavailable.
- Show local supplies and labor teams in the Hearthmere panel.

Minimum test:

> The player can assign labor to one project and see that the same labor cannot also be used somewhere else.

##### Milestone 4 — Prospecting Loop

Purpose: make discovery begin before extraction.

Build tasks:

- Add three prospect sites.
- Add a Survey Prospect action.
- Survey consumes labor and time.
- Survey can reveal: true deposit, mundane/low-yield site, or false/exhausted lead.
- Add survey-complete notification.
- Update the prospect panel after survey.
- If the true deposit is found, create a first material Codex entry.

Minimum test:

> The player surveys a site and either finds the true material deposit or learns the lead was not useful.

##### Milestone 5 — Material Profile and Codex

Purpose: make the material feel unknown, then gradually understood.

Build tasks:

- Define material profile data with hidden variant fields.
- Define discovered/known fields separately from hidden fields.
- Create a Codex panel.
- Codex starts with basic observed description only.
- Add a Basic Test or Academy Analysis project.
- On completion, reveal one or more properties.
- Add Codex update notification.

Minimum test:

> The same material starts partly unknown, then the Codex updates after testing.

##### Milestone 6 — Deposit, Mine, and Local Stockpiles

Purpose: make extraction local and physical.

Build tasks:

- Add Claim Deposit project.
- Add Establish Mine project.
- Add mine state: unclaimed, claimed, establishing, active, paused.
- Add mine supply stockpile.
- Add mine ore stockpile.
- Mine consumes supplies while active.
- Mine produces ore into its local stockpile only while supplied.
- Show mine stockpiles in the mine panel.
- Make mine pause or slow when supplies run out.

Minimum test:

> The mine only produces ore if supplies exist at the mine, and ore appears at the mine rather than globally.

##### Milestone 7 — Shipments and Routes

Purpose: prove that goods move physically.

Build tasks:

- Add shipment/caravan object.
- Shipment has cargo, origin, destination, route, travel progress, and ETA.
- Add Create Supply Shipment from Hearthmere to mine.
- Add Create Ore Shipment from mine to Hearthmere.
- Make shipments move along routes over hourly ticks.
- Cargo transfers only when shipment arrives.
- Add shipment panel.
- Add shipment departed/arrived notifications.
- Support at least fast route and slow route travel times.

Minimum test:

> Supplies and ore are not usable at the destination until the shipment physically arrives.

##### Milestone 8 — First Material Output

Purpose: connect discovery to a concrete choice.

Build tasks:

- Add a Forge/Test/Output panel or actions in Hearthmere.
- Add output project options based on delivered ore.
- At minimum support one of:
  - Forge basic Redglass weapons,
  - Forge Redglass shields/armor,
  - Prepare a non-combat utility output,
  - or complete an academy-confirmed material application.
- Output consumes ore, labor, and time.
- Output result references known material properties.
- Add completion notification.

Minimum test:

> The player turns delivered ore and discovered knowledge into a finished output.

##### Milestone 9 — Phase 1 Completion Summary

Purpose: make the prototype feel like a complete slice.

Build tasks:

- Add Phase 1 completion condition.
- Show summary screen when reached.
- Summary should list:
  - prospects surveyed,
  - material discovered,
  - properties revealed,
  - supplies moved,
  - ore moved,
  - labor committed,
  - output completed,
  - and unknown future risks.
- Add restart/replay button.

Minimum test:

> The player can complete the no-combat loop and understand what happened.

#### Phase 1A Cut Line

If the project starts feeling too large, cut everything except this:

- one map,
- Hearthmere,
- three prospects,
- one true deposit,
- labor teams,
- supplies,
- survey project,
- mine project,
- local stockpiles,
- shipment movement,
- one material test,
- Codex update,
- one output project,
- completion summary.

Everything else can wait.

Do not cut local stockpiles, physical supplies, time-based projects, or Codex updates. Those are the point of the prototype.

#### Solo Developer Anti-Scope Rules

Use these rules when tempted to add more.

1. **If it does not support Phase 1A, defer it.**
2. **If it requires AI, defer it.**
3. **If it requires combat, defer it.**
4. **If it requires procedural generation, hard-code it first.**
5. **If it requires art, use icons/placeholders first.**
6. **If it requires balance, expose debug values and test later.**
7. **If it requires a complex UI, start with a plain text panel.**
8. **If it is only cool after raiders exist, defer it to Phase 2.**
9. **If it is only cool after tactical battles exist, defer it to the tactical prototype.**
10. **If it is not visible to the player, question whether it is needed yet.**

#### Recommended Initial Data Objects

The first build can use simple data objects. These are not final schemas.

```text
GameState
- currentHour
- isPaused
- speed
- selectedObjectId
- eventLog[]
- regions[]
- routes[]
- settlements[]
- prospects[]
- deposits[]
- stockpiles[]
- projects[]
- shipments[]
- materials[]
- codexEntries[]
```

```text
Settlement
- id
- name
- regionId
- population
- availableWorkforce
- laborTeamSize
- availableLaborTeams
- assignedLaborTeams
- localStockpileId
- facilities[]
```

```text
Project
- id
- type
- ownerObjectId
- status
- remainingHours
- requiredLaborTeams
- requiredMaterials
- onCompleteEffect
```

```text
Stockpile
- id
- locationObjectId
- capacityByGood
- amountsByGood
```

```text
Shipment
- id
- cargoGood
- cargoAmount
- originObjectId
- destinationObjectId
- routeId
- remainingHours
- status
```

```text
MaterialProfile
- id
- displayName
- variantId
- hiddenProperties
- revealedProperties
- sourceDepositId
```

```text
CodexEntry
- materialId
- observedText
- revealedProperties[]
- fieldNotes[]
- unknowns[]
```

Keep these flat at first. Avoid inheritance, entity-component architecture, or deep simulation architecture until the prototype proves it needs them.

#### Debug Tools Are Required, Not Optional

A solo developer needs fast iteration. Debug tools should be built early.

Minimum debug tools:

- reset scenario,
- pause/play,
- advance 1 hour,
- advance 12 hours,
- complete selected project,
- add supplies to selected stockpile,
- add ore to selected stockpile,
- reveal material property,
- switch material variant,
- print current local stockpiles,
- show active projects,
- show active shipments.

These tools are not polish. They are how the prototype gets tuned.

#### First Internal Playtest Script

When Phase 1A is playable, run this script:

1. Start scenario.
2. Inspect Hearthmere.
3. Inspect all prospect sites.
4. Survey one prospect.
5. If false/poor, survey another.
6. Confirm true deposit.
7. Claim deposit.
8. Establish mine.
9. Send supplies to mine.
10. Wait for supplies to arrive.
11. Mine first ore batch.
12. Send ore to Hearthmere.
13. Run material test or analysis.
14. Read Codex update.
15. Start first output project.
16. Complete output.
17. Read summary.

After the run, answer:

- Did I understand where every resource was?
- Did labor scarcity affect my choices?
- Did supplies feel physical?
- Did shipment movement matter?
- Did the Codex update change my understanding?
- Did the output feel like a payoff?
- Did I want something to threaten this chain?

If the answer to the last question is yes, Phase 1A is ready for Phase 2 pressure.

#### First Public Demo Target

The first public/internal demo target should not be the full v0.1 roadmap. It should be one of these, in order of ambition:

1. **Systems demo:** complete Phase 1A with placeholder UI and no raiders.
2. **Pressure demo:** Phase 1A plus visible raider entities and one caravan ambush.
3. **Strategy demo:** Phase 1–3 with raiders, escorts, local security, and one material-driven combat result.

For a solo developer, the safest first target is the systems demo. It proves whether the foundation is interesting before adding the expensive layers.

#### Final Solo Developer Principle

> The prototype should earn complexity. Build the smallest version that makes the player care about a material, a mine, a shipment, a stockpile, and a decision. Only then add enemies who threaten those things.

