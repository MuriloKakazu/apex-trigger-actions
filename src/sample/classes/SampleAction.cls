public class SampleAction extends TriggerAction {
    public override TriggerAction.Configuration configure() {
        return getConfiguration()
            .runBeforeInsert()
            .runBeforeUpdate();
    }

    public override void run(TriggerContext context) {

        for (Account account : (Account[]) context.getNewRecords()) {
            // ...
        }

    }
}
