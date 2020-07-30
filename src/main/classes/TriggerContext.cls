public class TriggerContext {
    private TriggerOperation operation;
    private SObject[] newRecords, oldRecords;
    private Map<Id, SObject> newRecordsMap, oldRecordsMap;

    public static TriggerContext current() {
        return new Builder()
            .withOperation(Trigger.operationType)
            .withNewRecords(Trigger.new)
            .withOldRecords(Trigger.old)
            .withNewRecordsMap(Trigger.newMap)
            .withOldRecordsMap(Trigger.oldMap)
            .build();
    }

    private TriggerContext() { }

    public TriggerOperation getOperation() {
        return operation;
    }

    public void setOperation(TriggerOperation operation) {
        this.operation = operation;
    }

    public SObject[] getNewRecords() {
        return newRecords;
    }

    public SObject[] getOldRecords() {
        return oldRecords;
    }

    public Map<Id, SObject> getNewRecordsMap() {
        return newRecordsMap;
    }

    public Map<Id, SObject> getOldRecordsMap() {
        return oldRecordsMap;
    }

    public SObject getNewRecord(Id recordId) {
        return newRecordsMap.get(recordId);
    }

    public SObject getOldRecord(Id recordId) {
        return oldRecordsMap.get(recordId);
    }

    private void setNewRecords(SObject[] records) {
        newRecords = records;
    }

    private void setNewRecordsMap(Map<Id, SObject> recordsMap) {
        newRecordsMap = recordsMap;
    }

    private void setOldRecords(SObject[] records) {
        oldRecords = records;
    }

    private void setOldRecordsMap(Map<Id, SObject> recordsMap) {
        oldRecordsMap = recordsMap;
    }

    public class Builder {
        private TriggerContext context = new TriggerContext();

        public Builder withOperation(TriggerOperation operation) {
            context.setOperation(operation);
            return this;
        }

        public Builder withNewRecords(SObject[] newRecords) {
            context.setNewRecords(newRecords);
            return this;
        }

        public Builder withNewRecordsMap(Map<Id, SObject> newRecordsMap) {
            context.setNewRecordsMap(newRecordsMap);
            return this;
        }

        public Builder withOldRecords(SObject[] oldRecords) {
            context.setOldRecords(oldRecords);
            return this;
        }

        public Builder withOldRecordsMap(Map<Id, SObject> oldRecordsMap) {
            context.setOldRecordsMap(oldRecordsMap);
            return this;
        }

        public TriggerContext build() {
            TriggerContext builtContext = context;
            context = new TriggerContext();
            return builtContext;
        }
    }
}
