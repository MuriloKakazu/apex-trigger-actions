# Apex Trigger Actions

// TODO

## Usage

// TODO

### Decide what will and what won't run in the transaction

// TODO

#### Remove an action, so it's not run

// TODO

```apex
TriggerDispatcher.getInstance()
        .getHandler()
        .removeAction(AnAction.class);
```

#### Remove all actions on a Trigger Handler

// TODO

```apex
TriggerDispatcher.getInstance()
        .getHandler()
        .removeAllActions();
```

#### Disable everything, so no triggers are run

// TODO

```apex
TransactionConfiguration.disableTriggers();
```

### Declaring a new Trigger Action

// TODO

```apex
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
```

### Declaring a Trigger Handler

// TODO

```apex
public class AccountTriggerHandler extends TriggerHandler {

    public override TriggerHandler.Configuration configure() {
        return getConfiguration().addActions(new Set<Type> {
                SampleAction.class,
                AnotherAction.class
        });
    }
}
```

### Adding Trigger Handler to Apex Trigger

// TODO

```apex
trigger AccountTrigger on Account (before insert, before update) {

    TriggerDispatcher.getInstance()
            .getHandler(AccountTriggerHandler.class)
            .run();
}
```