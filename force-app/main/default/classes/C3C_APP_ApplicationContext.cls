public class C3C_APP_ApplicationContext 
{
    /* Atributos */
    public static C3C_APP_ContractInterfaceApplication contract {
        get
        {
            if(contract == null)
                contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance('C3C_APP_ContractInterfaceApplication');
            return contract;
        }
        private set;
    }
    public static fflib_ISObjectUnitOfWork uow 
    {
        get;   
        set
        {
            uow = value;  
            hasUow = true;
        }
    }
    
    private static Boolean hasUow = false;
    /* Fim Atributos */

    /* Métodos */
    public static void initialize(C3C_APP_ContractInterfaceApplication contractParam)
    {
        contract = contractParam;
    }

    public static C3C_APP_ContractInterfaceApplication finalize()
    {
        if(hasUow && uow != null)
            uow.commitWork();

        if(contract != null)
        {
            contract.checkIfError();
            contract.checkWarnings();
        }

        contract.convertResponseToReturnType();
        return contract;
    }

    public static Map<String, string> getBody()
    {
        return contract.requestBody.bodyMap;
    }

    public static String getJSONByBody(String paramName)
    {
        if(!getBody().containsKey(paramName))
            return '';
            
        String jsonBody = getBody().get(paramName);

        jsonBody = jsonBody.replace('%aspasduplas%,', '",');
        jsonBody = jsonBody.replace('%aspasduplas%}', '"}');

        return jsonBody;
    }

    public static void setResponse(Object response)
    {
        if(contract == null)
            return;
        contract.response = response;
    }

    public static void addNewReferencePagination(Object lastValue)
    {
        if(contract != null)
            contract.addNewReferencePagination(lastValue);
    }
    
    public static Object getReferencePaginationByPage(Integer page)
    {
        if(contract == null && contract.mapPagination == null)
            return null;

        return contract.mapPagination.containsKey(page) ? contract.mapPagination.get(page) : null;
    }
    
    public static void addPath(String className, String methodName, Map<String, Object> params, Object response)
    {
        contract.addPath(className, methodName, params, response);
    }

    //Methods add erros
    public static void addCriticalError(String erroCode, String messageLabelOrText)
    {
        contract.addError(C3C_APP_ContractInterfaceApplication.ErrorRating.Critical, erroCode, messageLabelOrText);
    }
    public static void addHighError(String erroCode, String messageLabelOrText)
    {
        contract.addError(C3C_APP_ContractInterfaceApplication.ErrorRating.High, erroCode, messageLabelOrText);
    }
    public static void addMidError(String erroCode, String messageLabelOrText)
    {
        contract.addError(C3C_APP_ContractInterfaceApplication.ErrorRating.Mid, erroCode, messageLabelOrText);
    }
    public static void addLowError(String erroCode, String messageLabelOrText)
    {
        contract.addError(C3C_APP_ContractInterfaceApplication.ErrorRating.Low, erroCode, messageLabelOrText);
    }

    //Methods add warnings
    public static void addCriticalWarning(String warningCode, String messageLabelOrText)
    {
        contract.addWarning(C3C_APP_ContractInterfaceApplication.WarningRating.Critical, warningCode, messageLabelOrText);
    }
    public static void addHighWarning(String warningCode, String messageLabelOrText)
    {
        contract.addWarning(C3C_APP_ContractInterfaceApplication.WarningRating.High, warningCode, messageLabelOrText);
    }
    public static void addMidWarning(String warningCode, String messageLabelOrText)
    {
        contract.addWarning(C3C_APP_ContractInterfaceApplication.WarningRating.Mid, warningCode, messageLabelOrText);
    }
    public static void addLowWarning(String warningCode, String messageLabelOrText)
    {
        contract.addWarning(C3C_APP_ContractInterfaceApplication.WarningRating.Low, warningCode, messageLabelOrText);
    }
    /* Fim Métodos */
}