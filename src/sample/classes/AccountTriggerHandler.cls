public class AccountTriggerHandler extends TriggerHandler {
    public override TriggerHandler.Configuration configure() {
        return getConfiguration().addActions(new Set<Type> {
                SampleAction.class
        });
    }
}