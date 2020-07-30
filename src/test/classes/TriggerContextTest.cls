@IsTest
public class TriggerContextTest {

    @IsTest
    private static void shouldBuildContext() {
        // given - sample context data
        TriggerOperation operation = TriggerOperation.AFTER_INSERT;

        SObject newRecord = new Account(Id = '001000000000001');
        SObject oldRecord = new Account(Id = '001000000000002');

        Map<Id, SObject> newRecordMap = new Map<Id, SObject> {
            newRecord.Id => newRecord
        };

        Map<Id, SObject> oldRecordMap = new Map<Id, SObject> {
            oldRecord.Id => oldRecord
        };
        
        // when - building context
        TriggerContext context = new TriggerContext.Builder()
            .withOperation(operation)
            .withNewRecords(newRecordMap.values())
            .withOldRecords(oldRecordMap.values())
            .withNewRecordsMap(newRecordMap)
            .withOldRecordsMap(oldRecordMap)
            .build();

        // then - context is correctly created
        System.assertEquals(operation, context.getOperation());

        System.assertEquals(newRecordMap.size(), context.getNewRecords().size());
        System.assertEquals(oldRecordMap.size(), context.getOldRecords().size());

        System.assertEquals(newRecord, context.getNewRecords().get(0));
        System.assertEquals(oldRecord, context.getOldRecords().get(0));

        System.assertEquals(newRecord, context.getNewRecordsMap().get(newRecord.Id));
        System.assertEquals(oldRecord, context.getOldRecordsMap().get(oldRecord.Id));
    }
    
}
