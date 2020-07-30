@IsTest
public class TriggerHandlerTest {

    private class TestHandler extends TriggerHandler {
        public override TriggerHandler.Configuration configure() {
            return getConfiguration();
        }
    }

    private class RunOnBeforeAction extends TriggerAction {
        public override TriggerAction.Configuration configure() {
            return getConfiguration()
                    .runBeforeInsert()
                    .runBeforeUpdate();
        }
    
        public override void run(TriggerContext context) { }
    }

    private class RunOnAfterAction extends TriggerAction {
        public override TriggerAction.Configuration configure() {
            return getConfiguration()
                    .runAfterInsert()
                    .runAfterUpdate();
        }

        public override void run(TriggerContext context) { }
    }

    @IsTest
    private static void shouldContainAction() {
        // given - a handler
        TriggerHandler handler = new TestHandler();

        handler.addAction(RunOnBeforeAction.class);

        // then - handler contains action that was added
        System.assert(handler.containsAction(RunOnBeforeAction.class));
    }

    @IsTest
    private static void shouldNotContainAction() {
        // given - a handler
        TriggerHandler handler = new TestHandler();

        // then - handler does not contain action that was never added
        System.assert(!handler.containsAction(RunOnAfterAction.class));
    }

    @IsTest
    private static void shouldRemoveAction() {
        // given - a handler
        TriggerHandler handler = new TestHandler();

        // and - contains action
        handler.addAction(RunOnBeforeAction.class);

        // when - removing action
        handler.removeAction(RunOnBeforeAction.class);

        // then - action was removed
        System.assert(!handler.containsAction(RunOnBeforeAction.class));
    }

    @IsTest
    private static void shouldRemoveAllActions() {
        // given - a handler
        TriggerHandler handler = new TestHandler();

        // and - with multiple actions
        handler.addAction(RunOnBeforeAction.class)
                .addAction(RunOnAfterAction.class);

        // when - removing all actions
        handler.removeAllActions();

        // then - no actions left
        System.assertEquals(0, handler.configuration.actions.size());
    }

    @IsTest
    private static void shouldRejectInvalidActions() {
        // given - a handler
        TriggerHandler handler = new TestHandler();

        // when - adding invalid action
        try {
            handler.addAction(Account.class);
        } catch (IllegalArgumentException e) {
            // then - IllegalArgumentException thrown
        }
    }

    @IsTest
    private static void shouldRejectDuplicateActions() {
        // given - a handler
        TriggerHandler handler = new TestHandler();

        // and - already contains action
        handler.addAction(RunOnBeforeAction.class);

        // when - adding duplicate action
        try {
            handler.addAction(RunOnBeforeAction.class);
        } catch (TriggerHandler.ConstraintException e) {
            // then - ConstraintException thrown
        }
    }

}
