trigger SampleAccountTrigger on Account (before insert, before update) {
    TriggerDispatcher.getInstance()
            .getHandler(AccountTriggerHandler.class)
            .run();
}