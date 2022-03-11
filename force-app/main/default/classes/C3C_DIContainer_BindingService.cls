public class C3C_DIContainer_BindingService implements C3C_DIContainer_IBindingService {
    public C3C_DIContainer_BindingDomain getBindingByKey(String key)
    {
        for(SObject di_binding : (List<SObject>) ((C3C_DIContainer_IBindingSelector) C3C_DIContainer_Injector.getInstance('C3C_DIContainer_BindingSelector')).getBindingByKey(key))
            return (C3C_DIContainer_BindingDomain) C3C_DIContainer_Injector.newInstance('C3C_DIContainer_BindingDomain', di_binding);

        return null;
    }
}