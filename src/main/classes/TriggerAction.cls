public abstract class TriggerAction {

    @TestVisible
    private Configuration configuration = new Configuration();

    public abstract Configuration configure();
    public abstract void run(TriggerContext context);

    protected TriggerAction() {
        this.configuration = configure();
    }

    protected Configuration getConfiguration() {
        return configuration;
    }

    public Boolean allowsOperation(TriggerOperation operation) {
        return configuration.allowsOperation(operation);
    }

    public class Configuration {

        @TestVisible
        private Set<TriggerOperation> operations = new Set<TriggerOperation>();

        private Boolean allowsOperation(TriggerOperation operation) {
            return operations.contains(operation);
        }
        
        public Configuration runBeforeInsert() {
            operations.add(TriggerOperation.BEFORE_INSERT);
            return this;
        }

        public Configuration runBeforeUpdate() {
            operations.add(TriggerOperation.BEFORE_UPDATE);
            return this;
        }

        public Configuration runBeforeDelete() {
            operations.add(TriggerOperation.BEFORE_DELETE);
            return this;
        }

        public Configuration runAfterInsert() {
            operations.add(TriggerOperation.AFTER_INSERT);
            return this;
        }

        public Configuration runAfterUpdate() {
            operations.add(TriggerOperation.AFTER_UPDATE);
            return this;
        }

        public Configuration runAfterDelete() {
            operations.add(TriggerOperation.AFTER_DELETE);
            return this;
        }

        public Configuration runAfterUndelete() {
            operations.add(TriggerOperation.AFTER_UNDELETE);
            return this;
        }
    }
}
