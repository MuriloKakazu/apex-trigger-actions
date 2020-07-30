public class TransactionConfiguration {
    private static Boolean triggersEnabled = true;

    private TransactionConfiguration() {}

    public static Boolean areTriggersEnabled() {
        return triggersEnabled;
    }

    public static void enableTriggers() {
        triggersEnabled = true;
    }

    public static void disableTriggers() {
        triggersEnabled = false;
    }
}