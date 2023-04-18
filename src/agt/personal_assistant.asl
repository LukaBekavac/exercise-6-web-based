// personal assistant agent


// Beliefs of the agent
prefer_wakeup_with_art(2).
prefer_wakeup_with_nat(1).

//inference rules
best_option("artificial"):- prefer_wakeup_with_art(Art) & prefer_wakeup_with_nat(Nat) & Art < Nat.
best_option("natural"):- prefer_wakeup_with_art(Art) & prefer_wakeup_with_nat(Nat) & Art > Nat.


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
    postDweet;
    .wait(8000);
    !greetUser.

@create_and_use_dweet
+!createDweetArtifact : true <-
makeArtifact("Dweet","room.DweetArtifact",[],ID);
.print("created artifact").

@greet_user_plan_awake
+!greetUser :  upcoming_event("now") & owner_state("awake") <-
    .print("Enjoy your Event!").

@greet_user_plan_asleep
+!greetUser :  upcoming_event("now") & owner_state("asleep") <-
    .print("Starting wake-up routine!");
    .broadcast(askAll, wake_method, Method);
    !use_Method(Method);
    .print("Using following to wake the user", Method).




/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }