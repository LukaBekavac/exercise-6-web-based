// blinds controller agent

/* Initial beliefs */

// The agent has a belief about the location of the W3C Web of Thing (WoT) Thing Description (TD)
// that describes a Thing of type https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Blinds (was:Blinds)
td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Blinds", "https://raw.githubusercontent.com/Interactions-HSG/example-tds/was/tds/blinds.ttl").

// the agent initially believes that the blinds are "lowered"
blinds("lowered").

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: the agents believes that a WoT TD of a was:Blinds is located at Url
 * Body: greets the user
*/
@start_plan
+!start : td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Blinds", Url) <- .print("blinds ready");
makeArtifact("blinds", "org.hyperagents.jacamo.artifacts.wot.ThingArtifact", [Url], ArtId).

@set_blinds_state
+!set_blinds_state(State) : true <-
    invokeAction("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#SetState",  ["https://www.w3.org/2019/wot/json-schema#StringSchema"], [State])[ArtId];
    -+blinds(State);
    .print("Set blinds to state ", State);
    .send(personal_assistant, tell, blinds).


/*
 * Plan for raising the blinds
 * Triggering event: addition of goal !raise_blinds
 * Context: the agent believes that the blinds are currently lowered
 * Body: sets the state of the blinds to "raised" using the "was:SetState" action affordance
*/
@raise_blinds_plan
+!raise_blinds : blinds("lowered") <-
 blinds("raised");
    .print("Blinds have been raised").

/*
 * Plan for lowering the blinds
 * Triggering event: addition of goal !lower_blinds
 * Context: the agent believes that the blinds are currently raised
 * Body: sets the state of the blinds to "lowered" using the "was:SetState" action affordance
*/
@lower_blinds_plan
+!lower_blinds : blinds("raised") <-
  blinds("lowered");
    .print("Blinds have been lowered").

@blinds_plan
+blinds(State) : true <-
    .print("The blinds are in state ", State).

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }