public abstract class C3C_APP_ServiceApplicationAdapter 
{
    public class C3C_APP_ServiceApplicationAdapterException extends Exception {}
 
    /* Atributos */
    private Map<String, String> mapServiceMethodToClassMethod = this.getMapServiceMethodToClassMethod();
    /* Fim Atributos */
    
    /* Métodos */
    public abstract Map<String, String> getMapServiceMethodToClassMethod();

    public void executeServiceMethod()
    {
        String serviceMethod = C3C_APP_ApplicationContext.contract.requestBody.serviceMethod;
        if(!this.mapServiceMethodToClassMethod.containsKey(serviceMethod))
            throw new C3C_APP_ServiceApplicationAdapterException(String.format('O {0} não está disponível ou não existe.', new List<String>{serviceMethod})); 

       	((ClassMethod) (Type.forName(this.mapServiceMethodToClassMethod.get(serviceMethod))).newInstance()).callMethod();
    }

    /* Fim Métodos */
    
    public abstract class ClassMethod
    {
        public abstract void callMethod();
    }
}