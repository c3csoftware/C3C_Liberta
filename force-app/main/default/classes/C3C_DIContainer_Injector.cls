public class C3C_DIContainer_Injector 
{
    public class C3C_DIContainer_InjectorException extends Exception {}

    private static Map<String, Object> mapInstances 
    {
        get
        {
            if(mapInstances == null)
            {
                mapInstances = new Map<String, Object>();
                mapInstances.put('C3C_DIContainer_BindingSelector', getIntanceByClassName('C3C_DIContainer_BindingSelector'));
                mapInstances.put('C3C_DIContainer_BindingService', getIntanceByClassName('C3C_DIContainer_BindingService'));
                mapInstances.put('C3C_DIContainer_BindingDomain', 'C3C_DIContainer_BindingDomain');
                mapInstances.put('C3C_Lib_Database',  getIntanceByClassName('C3C_Lib_Database'));
            }

            return mapInstances;
        }
        set;
    } 

    private static Map<String, String> mapStubClass = new Map<String, String>();
    
    public static Object newInstance(String key, Object params)
    {
        return setInstance(key, params);
    }

    public static Object newInstance(String key)
    {
        return setInstance(key, null);
    }

    public static Object getInstance(String key)
    {
        if(mapInstances.containsKey(key) && !(mapInstances.get(key) instanceof String)){
            return mapInstances.get(key);
        }

        if(mapInstances.containsKey(key) && mapInstances.get(key) instanceof String)
            throw new C3C_DIContainer_InjectorException(key+' não estático então não podem ser encontradas. Use "newInstance" caso queira uma nova instancia com estado.');

        return setInstance(key, null);
    }

    public static void createInstance(String key, Object instance)
    {
        mapInstances.put(key, instance);
    }

    public static void createInstance(String key, Object classReference, String classStub)
    {
        mapInstances.put(key, classReference);
        mapStubClass.put(key, classStub);
    }

    public static Object setInstance(String key, Object params)
    {
        if(!(mapInstances.containsKey('C3C_DIContainer_BindingSelector') && mapInstances.containsKey('C3C_DIContainer_BindingDomain') && mapInstances.containsKey('C3C_DIContainer_BindingService')))
            throw new C3C_DIContainer_InjectorException('C3C_DIContainer_Injector não esta funcionando.');

        String className;
        Object instance;

        if(!mapInstances.containsKey(key)){
            C3C_DIContainer_BindingDomain C3C_DIContainer_binding = ((C3C_DIContainer_IBindingService) getInstance('C3C_DIContainer_BindingService')).getBindingByKey(key);

            if(C3C_DIContainer_binding == null)
                throw new C3C_DIContainer_InjectorException('C3C_DIContainer_Binding "'+key+'" não definido.');

            className = C3C_DIContainer_binding.nomeClasse;

            instance = params == null ? getIntanceByClassName(className) : getIntanceByClassName(className, params);

            if(C3C_DIContainer_binding.estatico)
                mapInstances.put(key, instance);
            else
                mapInstances.put(key, C3C_DIContainer_binding.nomeClasse);
        }
        else
        {
            if(mapInstances.get(key) instanceOf String)
            {
                className = (String) mapInstances.get(key);
                instance = params == null ? getIntanceByClassName(className) : getIntanceByClassName(className, params);
            }
            else if(Test.isRunningTest() && mapStubClass.containsKey(key))
                instance = params == null ? createInstanceByStub(mapInstances.get(key), mapStubClass.get(key)) : createInstanceByStub(mapInstances.get(key), mapStubClass.get(key), params);
            else
                instance = mapInstances.get(key);
        }

        return instance;
    }

    private static Object getIntanceByClassName(String className)
    {
        Object instance;

        try{
            Type toType = Type.forName(className);
            instance = toType.newInstance();
        }catch(Exception e){
            throw new C3C_DIContainer_InjectorException('Erro ao instanciar a classe '+className+', err: '+e.getMessage());
        }
        return instance;
    }

    private static Object getIntanceByClassName(String className, Object params)
    {
        Object toObject;
        try{
            Type toType = Type.forName(className);
            toObject = toType.newInstance();
        }catch(Exception e)
        {
            throw new C3C_DIContainer_InjectorException('Erro ao instanciar a classe '+className+', err: '+e.getMessage());
        }
        if(params != null)
        {
            if(toObject instanceof C3C_DI_IProvider)
            {
                return ((C3C_DI_IProvider) toObject).newInstance(params);
            }

            throw new C3C_DIContainer_InjectorException('Classe '+className+' não implementa a interface "C3C_DI_IProvider".');
        }

        return toObject;
    }

    private static Object createInstanceByStub(Object classReference, String classStub)
    {
        Object instance;

        try{
            Type toType = Type.forName(classStub);
            instance = Test.createStub((System.Type) classReference, (System.StubProvider) toType.newInstance());
        }catch(Exception e){
            throw new C3C_DIContainer_InjectorException('Erro ao instanciar a classe '+classStub+', err: '+e.getMessage());
        }
        return instance;
    }

    private static Object createInstanceByStub(Object classReference, String classStub, Object params)
    {
        Object toObject;
        try{
            Type toType = Type.forName(classStub);
            toObject = Test.createStub((System.Type) classReference, (System.StubProvider) toType.newInstance());
        }catch(Exception e)
        {
            throw new C3C_DIContainer_InjectorException('Erro ao instanciar a classe '+classStub+', err: '+e.getMessage());
        }

        return toObject;
    }
}