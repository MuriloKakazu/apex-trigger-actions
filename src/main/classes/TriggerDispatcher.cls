public class TriggerDispatcher {
    private static final Map<Type, TriggerHandler> handlers = new Map<Type, TriggerHandler>();
    private static final TriggerDispatcher instance = new TriggerDispatcher();

    public static TriggerDispatcher getInstance() {
        return instance;
    }

    private TriggerDispatcher() { }

    public TriggerHandler getHandler(Type handlerClass) {
        if (!handlers.containsKey(handlerClass)) {
            handlers.put(handlerClass, (TriggerHandler) handlerClass.newInstance());
        }

        return handlers.get(handlerClass);
    }
}
