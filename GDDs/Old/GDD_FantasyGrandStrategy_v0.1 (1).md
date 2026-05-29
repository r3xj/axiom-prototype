# Game Design Document
## *Working Title: AXIOM* — Fantasy Grand Strategy
**Version 0.1 — Initial Design Draft**

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

## 12. Out of Scope (For Now)

Features intentionally deferred to avoid scope creep on the initial prototype:

- **Multiplayer** — The long-term vision is slow async multiplayer (days-per-move style). Not in v1.
- **Full Divine/Cult System** — Deities exist in v1 as world flavor and passive influence. Active cult mechanics are a later layer.
- **Character-level drama** — Named rulers, marriage, inheritance (CK3-style) are a possible future system but not core to v1.
- **Naval systems** — Sea movement, naval logistics, island territories.
- **Full diplomacy treaty system** — v1 diplomacy can be simple (ally/neutral/hostile). Deep treaty mechanics come later.

---

*Document status: Living draft. Update with each design session.*
*Next step: Resolve Open Design Questions 1–3 to define the v0.1 prototype scope.*
