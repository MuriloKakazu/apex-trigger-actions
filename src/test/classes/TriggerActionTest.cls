@IsTest
public class TriggerActionTest {

    private class TestAction extends TriggerAction {
        public override TriggerAction.Configuration configure() {
            return getConfiguration()
                .runBeforeInsert()
                .runBeforeUpdate();
        }
    
        public override void run(TriggerContext context) { }
    }

    @IsTest
    private static void shouldAllowConfiguredOperations() {
        // given - an action
        TestAction action = new TestAction();

        // then - should allow configured operations
        System.assert(action.allowsOperation(TriggerOperation.BEFORE_INSERT));
        System.assert(action.allowsOperation(TriggerOperation.BEFORE_UPDATE));
    }

    @IsTest
    private static void shouldNotAllowNonConfiguredOperations() {
        // given - an action
        TestAction action = new TestAction();

        // then - should not allow non-configured operations
        System.assertEquals(false, action.allowsOperation(TriggerOperation.AFTER_INSERT));
        System.assertEquals(false, action.allowsOperation(TriggerOperation.AFTER_UPDATE));
    }

}
