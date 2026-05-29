# Game Design Document
## *Working Title: AXIOM* — Fantasy Grand Strategy
**Version 0.28 — Prototype Commitment Capacity Model Added**

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

*Document status: Living draft — all v0.1 design questions resolved; discovery-first prototype thesis, raider pressure, counterplay, and prototype codex reveal model added.*

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
   - *Reddish, glassy, unusually heavy, warm to the touch.*

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
| **Observed** | *Reddish, glassy, heavy, warm to the touch.* |
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

   - reddish, glassy ore
   - unusually dense
   - warm to the touch
   - rings sharply when struck
   - unknown practical and magical behavior

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

### 13.22 Prototype Combat Resolution Model

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
| **Strength / Condition** | A simple readiness state, such as Ready, Wounded, Routed, or Broken |
| **Role / Assignment** | Escorting, guarding, scouting, patrolling, attacking, or idle |
| **Equipment** | Current weapons, armor/shields, and any known material-derived modifiers |

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

### 13.23 Prototype Scenario End Conditions and Victory Paths

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


### 13.24 Prototype Resource and Starting Asset Model

The resource and asset model is foundational to AXIOM, but v0.1 should only implement the minimum needed to make discovery, logistics, equipment choice, and raider pressure function. Long-term economic design should not be ignored; it should be explicitly deferred where the prototype does not need it yet.

#### Design Principle

> Prototype resources should be few, local, and immediately decision-relevant. Long-term AXIOM resources should grow into a deeper physical economy, but v0.1 only needs the assets required to prove that discovery becomes strategy.

The player should begin with enough assets to make several plausible opening moves, but not enough to do everything at once. Starting resources should create prioritization pressure, not bookkeeping.

#### Minimum v0.1 Resources

The prototype should use a small set of resources that map directly to implemented systems:

| Resource / Asset | Prototype Role |
|---|---|
| **Population / Labor Pool** | Provides workers for surveying, mining, forging, research, guard duty, and basic settlement tasks. Represented abstractly. |
| **Coin / Liquid Value** | Flexible spendable value used for construction, hiring, rush actions, or trade-like costs. This can be called Coin, Treasury, Stores, or another setting-appropriate term. |
| **Supplies / Rations** | Concrete physical goods produced by settlements over time and consumed by mines, remote squads, caravans, guard posts, and eventually settlements themselves. Supplies exist in local stockpiles and must be shipped where needed. |
| **Basic Weapons Stockpile** | Determines how many squads can be equipped for basic attack/combat readiness before Redglass equipment exists. |
| **Basic Armor / Shield Stockpile** | Determines how many squads can be equipped for basic defense/guard duty before Redglass equipment exists. |
| **Material Stockpiles** | Local stockpiles of discovered materials. Redglass must exist physically at the mine, caravan, forge, academy, or settlement. No global inventory. |
| **Known Prospect Leads** | Visible opportunities the player can survey. Some are fruitful; some are mundane, low-yield, exhausted, or false. |
| **Squads / Parties** | Physical units that can move directly or be assigned to guard, escort, scout, survey, patrol, or attack. |
| **Facilities** | Hearthmere, Forge, Academy, Stockpile, and any established Mine/Extraction Site. |

#### Starting Assets for v0.1

The exact numbers can be tuned later, but the prototype should begin with the following categories:

- **Hearthmere**, the capital settlement.
- A small **Population / Labor Pool** large enough to support one or two major priorities at once, but not all priorities simultaneously.
- A small amount of **Coin / Liquid Value** sufficient to survey, claim, and begin exploiting one good prospect, but limited enough that false starts matter.
- A starting **Supplies** stockpile at Hearthmere, plus a simple Hearthmere supply production rate. The starting stockpile should support early mining and squad movement, but not enough to ignore supply throughput forever.
- A modest **Basic Weapons Stockpile** and **Basic Armor / Shield Stockpile** sufficient to equip a basic guard/militia squad.
- One **basic militia/guard squad** capable of local defense, escort, patrol, and simple attacks.
- One **survey capacity**, represented either by a physical survey party or a settlement assignment.
- A basic **Forge** and **Academy** at Hearthmere, possibly inefficient or idle until assigned labor/materials.
- Several visible **prospect leads** in nearby regions.
- Basic local knowledge of the surrounding region-node map, including at least one known danger area.

The player should not begin with a blank slate or a single Civ-style scout. They should begin with an imperfect local situation and enough tools to choose a first strategy.

#### Concrete Supplies and Field Operations

Supplies should be a concrete good, not merely an abstract unit-stamina value. This is important because supplies create pressure points that enemies can exploit and the player can protect, reroute, stockpile, or neglect.

For v0.1, supplies should remain simple but physical:

- **Supplies are produced by settlements over time.** Hearthmere produces a fixed amount of supplies per time interval. Long-term, other settlements, farms, depots, trade routes, or conquered regions may add additional supply sources.
- **Supplies are stored locally.** Hearthmere begins with a supply stockpile. A mine, caravan, squad, or remote guard post only has the supplies physically present there or delivered there.
- **Supplies limit activity.** The player may have enough labor to mine, guard, scout, forge, and march, but not enough supplies to support all of those activities at once.
- **Mines consume supplies.** An active extraction site requires periodic supply deliveries from Hearthmere. If the mine runs out, extraction slows, pauses, or becomes vulnerable to worker desertion/disorder.
- **Squads consume supplies away from Hearthmere.** A squad guarding a remote mine, escorting caravans, scouting Ashen Pass, or attacking Blackbanner Camp draws from carried supplies or a nearby supplied site. Moving or campaigning units consume more supplies than idle local defenders.
- **Caravans can carry supplies.** A route may move ore back to Hearthmere, supplies out to the mine, or both through separate shipments.
- **Supplies can be raided.** A raider attack on a supply caravan may not feel as dramatic as stealing Redglass, but it can indirectly shut down extraction or weaken field squads.
- **Supply importance changes with context.** Under normal conditions, occasional bandit losses may be tolerable. During drought, siege, winter, scarcity, or a major campaign, the same supply route may become critical enough to justify escorts.

The v0.1 implementation does not need a full food economy, spoilage model, or civilian consumption simulation. It only needs to prove that supplies are physical goods that are produced, consumed, transported, and vulnerable. Supplies should function as an in-world limiter on expansion rather than an abstract unit cap.

Minimum v0.1 supply rules:

1. Hearthmere has a supply stockpile.
2. Hearthmere produces supplies over time.
3. The Redglass mine consumes supplies while active.
4. Remote squads consume supplies while assigned away from Hearthmere, with moving/active squads consuming more than stationary local defenders.
5. The player can create a supply shipment route from Hearthmere to the mine or a guard post.
6. If a mine or remote squad lacks supplies, it becomes less effective or stops functioning.
7. Raiders can choose supply shipments as targets when those shipments are exposed.
8. The player can outpace supply production by running too many remote, industrial, or military activities at once.

Long-term, supplies can expand into food, rations, fodder, ammunition, tools, medicine, road depots, emergency requisition, seasonal scarcity, town consumption, famine, siege logistics, and military supply networks.

#### Supply Production, Throughput, and Expansion Pressure

Supplies are not only a maintenance cost. They are a strategic throughput system. Settlement production determines how much sustained activity the faction can support, while logistics determines whether those supplies reach the places that need them.

This creates a natural limiter on growth:

- The player cannot maintain too many active military units because marching and campaigning consume supplies.
- The player cannot cover the map with mines, guard posts, and industry unless supply production and delivery capacity grow alongside them.
- The player may have enough labor to open another site, but not enough supplies to keep those workers fed, equipped, and operating.
- A remote mine may be profitable on paper but fragile if supplies must cross a dangerous route.
- A small recurring loss to bandits may be acceptable in normal times, but catastrophic during drought, siege, winter, or a military campaign.

For v0.1, this can be represented with a simple model:

- Hearthmere produces supplies at a fixed rate.
- Hearthmere has a maximum local supply stockpile.
- The Redglass mine consumes supplies while active.
- A guard post or remote squad consumes supplies while assigned.
- Caravans physically move supplies from Hearthmere to remote stockpiles.
- If consumption and losses exceed production and delivery, remote activity begins to fail.

The design goal is not to make the player solve a spreadsheet. The goal is to make logistics visible as a living constraint: do you have the fuel for the labor, the route capacity to deliver it, and the resilience to survive shortages or raids?


#### Prototype Commitment Capacity

The starting economy should be tuned around meaningful commitments rather than precise final numbers. The player should begin with enough labor, supplies, equipment, and coin to pursue several important actions, but not enough to pursue every possible priority at full efficiency.

For v0.1, use a simple commitment-capacity target:

> Hearthmere can comfortably support roughly three major commitments at once. Each minor settlement or support site can eventually support one additional meaningful commitment.

A **major commitment** is any sustained activity that consumes labor, supplies, attention, equipment, or route capacity. Examples include:

- operating the Redglass mine,
- running the forge on a meaningful equipment project,
- running academy analysis,
- maintaining a remote guard post,
- keeping a squad on active patrol/scouting duty,
- escorting a caravan route,
- preparing or executing an attack on Blackbanner Camp,
- or opening and sustaining a second extraction site.

This is not a hard board-game slot limit. It is a tuning target for the prototype economy. The player may exceed comfortable capacity, but doing so should create visible strain: slower production, supply shortages, idle facilities, unguarded routes, weaker patrol coverage, or more vulnerability to disruption.

The prototype should therefore aim for a starting situation where the player can do combinations such as:

- **Mine + Forge + Defend**: exploit the ore, make equipment, and keep one squad ready.
- **Mine + Research + Escort**: extract ore, study it, and protect shipments.
- **Survey + Mine + Scout**: search for the best site, begin extraction, and improve local knowledge.
- **Forge + Patrol + Attack Prep**: lean into military action but delay deeper research or expansion.

The player should not be able to comfortably do all of the following at once: survey every prospect, operate the mine, run the academy, run the forge, escort all caravans, guard the mine, patrol Ashen Pass, and prepare an attack. Choosing where to skimp is the point.

This also supports the long-term specialization philosophy. A perfectly balanced faction should be broadly competent but less efficient than a faction that leans into a real advantage. If the world gives the player an unusually valuable material, fertile land, strong forge culture, safe trade route, or magical production edge, the player should be able to specialize around it, produce surplus, and create a reason for trade or conflict.

For v0.1, the exact numeric values should be placeholders until playtesting. Tune the starting assets until the player repeatedly asks:

> “Which three things matter most right now, and what am I leaving exposed?”

Long-term, this commitment model should evolve into a deeper economy of labor specialization, food and supply production, equipment replacement, trade efficiency, settlement specialization, and world-specific comparative advantage.

#### Armory Levels

The prototype should distinguish between **having people** and **having equipment for those people**.

A settlement may have population but only enough weapons and armor to field a limited number of effective squads. This makes the first Redglass equipment decision more meaningful.

For v0.1, the armory can be simple:

- **Basic Weapons** allow a squad to fight with normal Attack.
- **Basic Armor / Shields** allow a squad to fight with normal Defense.
- **Redglass Weapons** or **Redglass Armor/Shields** replace or upgrade the relevant equipment slot after forging.
- The player should not need to manage individual swords or helmets. Use stockpile counts, equipment slots, or squad-level equipment states.

#### Value / Appeal

Appeal should be treated primarily as **value**, not beauty for its own sake.

A material can be strategically important because others want it, even if it is poor for weapons or armor. Gold is the obvious real-world analogue: its military usefulness is limited, but its social, economic, religious, and diplomatic value can be enormous.

For v0.1, Value / Appeal can have a simple effect such as:

- higher sale/trade value,
- higher raider interest,
- higher claim pressure,
- or higher reward if delivered to a settlement/project.

Long-term, Value / Appeal can feed trade, prestige, diplomacy, divine offerings, elite equipment, taxation, tribute, and faction desire.

#### Local Stockpiles

Even in the simple prototype, stockpiles should be local.

Redglass sitting at the mine is not available to the forge. Redglass in a caravan is vulnerable. Redglass at the Academy is being studied, not forged. Redglass in Hearthmere can be assigned to projects.

This supports the original logistics fantasy:

> The player does not own an abstract number called Redglass. The player owns ore in places.

#### Long-Term Resource Design Debt

The prototype should explicitly defer deeper economic questions rather than pretending they are solved.

Long-term AXIOM likely needs answers for:

- population classes and labor specialization,
- food and seasonal supply,
- rations and military supply lines,
- roads, depots, warehouses, and regional storage,
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

### 13.25 Updated v0.1 Build Scope

**Map:** Seven-region handcrafted region-node graph: Hearthmere, Redglass Foothills, Ashen Pass, Old Pine Road, Westmere Farms, Blackbanner Camp, and The Silent Border. Organic visual terrain, route-based movement, no visible hex grid. The map should contain multiple prospect opportunities inside or between regions, not one obviously correct mine marker.

**Factions:** One player faction, one local raider actor, one distant Legacy Empire border presence. The raider band does not need full strategic AI; it only needs enough behavior to notice exposed ore value, watch routes, raid mine stockpiles, intercept caravans, or steal samples from the discovered ore site.

**Starting situation:** The player begins with basic knowledge of the local area rather than a blank map. Nearby regions, major routes, several prospect opportunities, Hearthmere, and at least one known danger area should be visible from the start. The first decision is how to prioritize discovery, security, route knowledge, and preparation.

**Starting assets:** The player starts with Hearthmere, a small population/labor pool, limited coin/liquid value, a starting Hearthmere supply stockpile plus simple supply production, modest basic weapons and armor/shield stockpiles, one basic militia/guard squad, survey capacity, basic Forge and Academy access, several visible prospect leads, and basic knowledge of nearby regions. Supplies are included as concrete local goods produced by Hearthmere over time and used to support the mine, remote squads, guard posts, and other sustained activity.

**Prospecting:** The prototype should include several prospect sites. At least one becomes the true Redglass deposit after survey; at least one should be mundane, low-yield, false, or exhausted. Prospecting should use scouts/prospectors or a survey assignment and create opportunity cost before the extraction chain begins.

**Logistics chain:** Prospect Site → Survey → Deposit → Extraction Site → Local Stockpile → Caravan Route → Workshop/Forge or Research Site → Output → Destination. No global inventory. Supplies also move physically, especially from Hearthmere to the mine or to remote squads/guard posts.

**Discovery:** Tier 1 immediate observation, Tier 2 practical testing, and one simple Tier 3 academy analysis. Field discovery appears through combat/result notifications and Codex updates after equipment is used. The first material should use a scoped prototype attribute set: weapon suitability, armor/shield suitability, thermal response, weight/burden, workability, value/appeal, and one simple magical modifier only if it maps to an implemented stat. The Codex may state discovered effects explicitly for v0.1.

**Equipment fork:** The first scarce ore batch can be committed to weapons, armor, or research delay. Weapons and armor should produce different strategic postures because of the material's generated physical sliders, elemental responses, equipment form, crafting process, battle context, and delayed magical behavior, not because of fixed hard-coded bonuses.

**Staffing:** Settlement labor pools with broad priority sliders. One specialist slot per major facility, or one starting specialist who can improve either forging, testing, research, or caravan safety.

**Threat/pressure:** Ore discovery creates a local opportunity that raiders may respond to. The player is pressured to claim, extract, move, study, and use the ore before raiders interfere. Raiders primarily threaten ore caravans, mine stockpiles, and exposed supply shipments that keep the mine or remote squads functioning. They should appear as hidden, partially revealed, or visible map entities depending on player scouting and local vision.

**Counterplay:** The player can guard, scout, assign squads, establish temporary guard posts, escort caravans, move directly, or reduce exposed activity. For v0.1, raider pressure should be represented through visible or discoverable raider map entities rather than a player-facing attention meter. Mining, stockpiling, shipping, and forging rare ore create opportunities that raiders may respond to. Scouting, patrols, watchposts, escorts, smaller shipments, paused extraction, and alternate routes help the player see or manage that danger.

**Opening flow:** The first 10 minutes should move the player through prospecting, discovery, claim, extraction posture, first shipment, and first ore commitment. The player should inspect multiple prospect opportunities, survey at least one site, discover the strange material, claim the valuable deposit, choose a cautious or aggressive extraction posture, move ore through a physical route, and then commit the first batch to weapons, armor, or research/testing.

**UI/actions:** The prototype interaction model should be based on physical decision surfaces: map objects, settlements, facilities, prospect sites, deposits/mines, routes, caravans, squads, raiders, material entries, equipment projects, and notifications. Each surface should have a small context panel with local information and context-specific actions. Owned squads should support both direct movement and assignment-based behavior: guard, escort, scout, patrol, or establish a temporary guard post. Owned objects offer direct control; neutral and hostile objects usually offer inspection, scouting, avoidance, interception, or attack. Notifications summarize changes and jump back to world objects; they should not replace the map as the source of truth.

**Coalition AI:** Out of scope for the first playable prototype unless represented as a simple event or future-facing hint.

**Real-time:** Continuous with pause and speed controls. Crisis events auto-slow to minimum speed. The real-time hook should come from waiting for samples, caravans, tests, and threats to resolve.

**Combat:** Abstract result screen for v0.1 unless a small tactical test is cheap to implement. Squads need only simple Attack, Defense, Condition, Assignment, and Equipment values. Combat must support caravan ambushes, mine raids, settlement defense, raider skirmishes, camp assaults, and field discovery.

**Scenario endings:** The prototype should support at least one clear military victory, one defensive/logistics victory if feasible, and one clear defeat condition. The primary victory is clearing or dispersing Blackbanner Camp. A secondary victory can be securing the Redglass ore chain through a major raider threat. The primary defeat condition is Hearthmere being sacked after its defenses fail. Smaller failures such as lost caravans, stolen samples, bad material choices, and mine raids should usually be recoverable setbacks.

**The test:** One settlement, multiple prospect sites, one strange ore deposit discovered through survey, one mine that consumes supplies, at least one supply shipment, two route choices, one forge/workshop, one academy or research action, one equipment fork, one or more controllable squads, one local raider actor capable of contesting the ore chain, and scenario endings that test whether discovery can become strategy. If the player feels curiosity, pressure, and adaptation from that scenario, the foundation works.

### 13.26 Next Design Questions

The next unresolved prototype questions are:

1. What exact starting values should v0.1 use for labor, coin/liquid value, supply production/stockpiles, basic weapons, basic armor/shields, squads, and prospect leads?
2. What information appears in the Material Codex after each discovery step for one example Redglass roll?
3. What values and timings should v0.1 use for survey time, extraction rate, caravan travel, research progress, forging time, and raider response?
4. How much of the Survey Party should be a physical squad versus a settlement action/assignment for v0.1?
5. Which prototype victory paths should be required for the first playable build versus treated as optional stretch goals?
6. What minimum combat-result UI is needed to show outcome, losses, cargo status, and field discoveries?

*Recommended next session: assign rough starting values to the v0.1 resource/asset model, then define the example Redglass Codex reveal sequence.*
