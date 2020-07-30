public abstract class TriggerHandler {

    public class ConstraintException extends Exception {}

    @TestVisible
    private Configuration configuration = new Configuration();

    public abstract Configuration configure();

    protected TriggerHandler() {
        this.configuration = configure();
    }

    protected Configuration getConfiguration() {
        return configuration;
    }

    public void run() {
        if (!TransactionConfiguration.areTriggersEnabled()) return;

        run(TriggerContext.current());
    }
    
    @TestVisible
    private void run(TriggerContext context) {
        if (!TransactionConfiguration.areTriggersEnabled()) return;

        for (Type actionClass : getConfiguration().getActions()) {
            TriggerAction action = (TriggerAction) actionClass.newInstance();
            action.configure();

            if (!action.allowsOperation(context.getOperation())) continue;

            action.run(context);
        }
    }

    public Boolean containsAction(Type actionClass) {
        return getConfiguration().containsAction(actionClass);
    }

    public TriggerHandler addAction(Type actionClass) {
        getConfiguration().addAction(actionClass);
        return this;
    }

    public TriggerHandler removeAction(Type actionClass) {
        getConfiguration().removeAction(actionClass);
        return this;
    }

    public TriggerHandler removeAllActions() {
        getConfiguration().clearActions();
        return this;
    }

    public class Configuration {

        @TestVisible
        private Set<Type> actions = new Set<Type>();

        private Set<Type> getActions() {
            return actions;
        }

        private Boolean containsAction(Type actionClass) {
            return actions.contains(actionClass);
        }

        public Configuration addActions(Set<Type> actionClasses) {
            for (Type actionClass : actionClasses) {
                addAction(actionClass);
            }
            return this;
        }

        public Configuration addAction(Type actionClass) {
            validateActionClassIsValid(actionClass);
            validateActionIsNotDuplicate(actionClass);

            actions.add(actionClass);
            return this;
        }

        private Configuration removeAction(Type actionClass) {
            actions.remove(actionClass);
            return this;
        }

        private Configuration clearActions() {
            actions.clear();
            return this;
        }

        private void validateActionIsNotDuplicate(Type actionClass) {
            if (containsAction(actionClass)) {
                throw new ConstraintException('Action can not be added twice: ' + actionClass.getName());
            }
        }

        private void validateActionClassIsValid(Type actionClass) {
            if (!TriggerAction.class.isAssignableFrom(actionClass)) {
                throw new IllegalArgumentException(actionClass.getName() + 'is not an instance of TriggerAction');
            }
        }
    }

}
