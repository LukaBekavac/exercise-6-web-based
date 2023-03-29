// lights controller agent

/* Initial beliefs */

// The agent has a belief about the location of the W3C Web of Thing (WoT) Thing Description (TD)
// that describes a Thing of type https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Lights (was:Lights)
td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Lights", "https://raw.githubusercontent.com/Interactions-HSG/example-tds/was/tds/lights.ttl").

// The agent initially believes that the lights are "off"
lights("off").

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: the agents believes that a WoT TD of a was:Lights is located at Url
 * Body: greets the user
*/
@start_plan
+!start : td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#Lights", Url) <- .print("Lights are ready").
makeArtifact("lights", "org.hyperagents.jacamo.artifacts.wot.ThingArtifact", [Url], ArtId).

@set_lights_state
+!set_lights_state(State) : true <-
    invokeAction("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#SetState",  ["https://www.w3.org/2019/wot/json-schema#StringSchema"], [State])[ArtId];
    -+lights(State);
    .print("Set lights to state ", State);
    .send(personal_assistant, tell, lights(State)).

/*
 * Plan for turning-on the lights
 * Triggering event: addition of goal !turn_on_lights
 * Context: the agent believes that the lights are currently lowered
 * Body: sets the state of the lights to "raised" using the "was:SetState" action affordance
*/
@turn_on_lights_plan
+!turn_on_lights: lights("off") <-
 lights("on");
    .print("lights have been turned on").

/*
 * Plan for lowering the lights
 * Triggering event: addition of goal !lower_lights
 * Context: the agent believes that the lights are currently raised
 * Body: sets the state of the lights to "lowered" using the "was:SetState" action affordance
*/
@turn_off_lights_plan
+!lower_lights : lights("on") <-
  lights("off");
    .print("lights have been turned off").

@lights_plan
+lights(State) : true <-
    .print("The lights are in state ", State).






/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }