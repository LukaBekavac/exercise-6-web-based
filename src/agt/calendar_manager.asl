// calendar manager agent

/* Initial beliefs */

// The agent has a belief about the location of the W3C Web of Thing (WoT) Thing Description (TD)
// that describes a Thing of type https://was-course.interactions.ics.unisg.ch/wake-up-ontology#CalendarService (was:CalendarService)
td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#CalendarService",
 "https://raw.githubusercontent.com/Interactions-HSG/example-tds/was/tds/calendar-service.ttl").

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: the agents believes that a WoT TD of a was:CalendarService is located at Url
 * Body: greets the user
*/

@start_plan2
+!start : td("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#CalendarService", Url) <- .print("Calendar ready");
// performs an action that creates a new artifact of type ThingArtifact, named "calendar" using the WoT TD located at Url
// the action unifies ArtId with the ID of the artifact in the workspace
makeArtifact("upcoming_event", "org.hyperagents.jacamo.artifacts.wot.ThingArtifact", [Url], ArtId);
!read_upcoming_event. // creates the goal !read_upcoming_event
/*

    Plan for reacting to the addition of the goal !read_upcoming_event
    Triggering event: addition of goal !read_upcoming_event
    Context: true (the plan is always applicable)
    Body: the agent exploits the TD Property Affordance of type was:ReadUpcomingEvent to perceive the upcoming event

      and updates its belief upcoming_event accordingly

*/
@read_upcoming_event_plan
+!read_upcoming_event : true <-
// performs an action that exploits the TD Property Affordance of type was:ReadUpcomingEvent
// the action unifies EventLst with a list holding the upcoming event, e.g. ["now"]
readProperty("https://was-course.interactions.ics.unisg.ch/wake-up-ontology#ReadUpcomingEvent", EventLst);
.nth(0,EventLst,Event); // performs an action that unifies Event with the element of the list EventLst at index 0
-+upcoming_event(Event); // updates the belief upcoming_event
.wait(5000); // waits for 5 seconds
.send(personal_assistant, tell, upcoming_event(Event));
!read_upcoming_event. // creates the goal !read_upcoming_event

/*
    Plan for reacting to the addition of the belief !upcoming_event
    Triggering event: addition of belief !upcoming_event
    Context: true (the plan is always applicable)
    Body: announces the upcoming event
    */
    @upcoming_event_plan
    +upcoming_event(Event) : true <-
    .print("The upcoming event is ", Event).

{ include("$jacamoJar/templates/common-cartago.asl") }
