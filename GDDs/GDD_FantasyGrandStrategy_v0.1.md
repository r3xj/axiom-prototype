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

### 5.1 The Discovery State

Every material in the game exists in one of four discovery states for each player:

| State | What the Player Knows |
|-------|-----------------------|
| **Unknown** | The material exists and has been observed. Name, color, texture only. |
| **Partially Known** | Some physical properties identified (hardness, weight). Magical properties unknown. |
| **Analyzed** | Full physical properties known. Magical properties partially revealed. |
| **Mastered** | All properties known. Alloy behavior predictable. |

Players can craft with materials in any discovery state — but without full knowledge, results are partially unpredictable.

### 5.2 Methods of Discovery

**Formal Analysis (Wizard School / Academy)**
A research building that can be staffed and supplied with material samples. Running analyses takes time and requires the physical presence of the material. Analysis reveals properties in layers — physical properties first, magical last. Multiple scholars speed the process. Rival factions may also be running analyses; stealing their research is possible.

**Field Discovery**
Properties can reveal themselves through use:
- Armor made from fire-resistant ore reveals its resistance the first time soldiers survive fire damage they shouldn't have
- A crop with unusual nutrition reveals itself when population grows faster than expected
- A weapon made from a magically sharp material reveals its edge after unusual battlefield results

Field discovery is slower but free, and sometimes reveals properties that formal analysis misses (certain magical properties only activate under stress).

**Experimentation**
A dedicated facility (Alchemist's Workshop or similar) can run targeted experiments — "test this material against fire," "submerge it in water for 30 days," "strike it against this other material." Results are observable. This is faster than field discovery but uses material stock.

### 5.3 Crafting Without Full Knowledge

Players are never *required* to analyze before crafting. The game encourages bold use of unknown materials:

- A plate armor made from unknown ore will have properties the player doesn't know yet
- Those properties reveal over time through use (positive and negative)
- The player might discover their soldiers' new armor makes them mysteriously sluggish — or mysteriously feared

This creates genuine surprise and emergent storytelling. A commander might become legendary for surviving something that should have killed them, before anyone knows why.

### 5.4 Alloys

Two or more materials can be combined by a skilled enough blacksmith. Alloy behavior follows systematic rules — but the rules must also be discovered:

- Properties generally **combine** (armor with properties of both)
- Some properties **conflict** (fire-retaining + fire-conducting creates instability)
- Some properties **amplify** each other unexpectedly
- Rare combinations produce **emergent properties** not present in either source material

Alloy discovery is its own research layer. Early alloy experiments are guesswork; mastery comes from observation and documentation.

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

**Q1: How is the player introduced to unknown materials?**
The world can't just be labeled "unknown ore A, unknown ore B." Players need enough information to make decisions without having the mystery spoiled. What's the UX of interacting with an unidentified material?

**Q2: How do Legacy Empire arcs telegraph themselves?**
The Doomsday Architect shouldn't be a complete surprise. What are the clues? How does the player discover the threat exists before it's too late?

**Q3: What is the minimum viable logistics chain?**
The full chain described above is the ideal. But for prototyping, what's the smallest version that still captures the feel? (Mine → Caravan → Blacksmith might be enough for v1.)

**Q4: How does coalition AI work?**
When AI factions band together against a dominant player or a Doomsday Empire, how does that coalition form, communicate, and sustain itself? What prevents it from immediately fragmenting?

**Q5: What is the "just one more minute" hook in real-time?**
Turn-based games have a clear hook. Real-time grand strategy needs moments of tension and anticipation that keep the player engaged. What are they?

**Q6: How granular is staffing?**
Does the player assign individual named characters to facilities, assign population units, or something else? Named characters add drama but also complexity.

**Q7: What does the map look like?**
Hex grid? Free-form regions (Paradox style)? Something else? This decision affects almost every other system.

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
