// personal assistant agent

/* Initial goals */ 

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: true (the plan is always applicable)
 * Body: greets the user
*/
@start_plan
+!start : true <-
    .print("Hello world");
    !createDweetArtifact;
    postDweet.

@create_and_use_plan
+!createDweetArtifact : true <-
makeArtifact("Dweet","room.DweetArtifact",[],ID);
.print("created artifact").

@listen_to_events


/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }