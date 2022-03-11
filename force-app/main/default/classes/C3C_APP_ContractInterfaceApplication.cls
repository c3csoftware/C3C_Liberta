public class C3C_APP_ContractInterfaceApplication implements C3C_DI_IProvider
{
    /* Exception */
    public class C3C_APP_ContractInterfaceApplicationException extends Exception {}
    /* Fim Exception */
    
    /* Atributos */
    //Id único gerado pelo salesforce para rastrear a requisição -> Utilizado também para recuperar uma requisição assincrona 
    @AuraEnabled public String requestId {get; private set;}
    
    //InProgress, CompletedSuccess, CompletedError -> possiveis status para a requisição
    @AuraEnabled public String status {get; private set;}
     
    //Corpo da requsição formado por:
    //service -> Nome do serviço sendo chamado
    //serviceMethod -> Método do serviço sendo chamado
    //body -> Json contendo o corpo da requsição
    @AuraEnabled public Body requestBody {get;set;}
    
    //Retorno da requsição
    @AuraEnabled public Object response {get;set;}

    //Habilita o rastreamento do caminho da chamada, registrando métodos, classes, 
    //parametros e retornos de todos os componentes de software utilizados durante a execução do serviço
    //Utilizar em casos mais criticos ou para debugar o caminho
    @AuraEnabled public Boolean enabledPath = false;
    
    //Habilita o rastreamento de warnings
    @AuraEnabled public Boolean enabledWarning = false;

    //Tipo de retorno
    @AuraEnabled public String returnType {get;set;}

    //Lista dos itens contendo o caminho percorrido pela aplicação
    //Apenas preenchido quando enabledPath = true
    @AuraEnabled public List<ExecutionItem> path 
    {
        get
        {
            if(this.path == null)
                this.path = new List<ExecutionItem>();

            return this.path;
        }
        set;
    }  
    
    //Lista dos itens contendo os warnings disparados pela aplicação
    //Apenas preenchido quando enabledWarning = true
    @AuraEnabled public List<WarningItem> warnings 
    {
        get
        {
            if(this.warnings == null)
                this.warnings = new List<WarningItem>();

            return this.warnings;
        }
        set;
    }    
    
    //Lista dos erros lançados pela aplicação
    @AuraEnabled public List<ErrorItem> errors 
    { 
        get 
        {
            if(this.errors == null)
                this.errors = new List<ErrorItem>(); 

            return this.errors;
        }
        set;
    }    

    public Boolean isValid  
    {
        get
        {
            if(this.requestBody == null || Type.forName(this.requestBody.service+'Adapter') == null)
                throw new C3C_APP_ContractInterfaceApplicationException('O RequestBody é inválido ou vazio, por favor verifique sua requisição.');

            return true;
        }
        private set;
    }

    //Atributo que indica a páginação está ativada no contrato.
    @AuraEnabled public Boolean paginationAble = false;
    
    //Atributo que armazenará as referências de páginação.
    @AuraEnabled public Map<Integer, Object> mapPagination = new Map<Integer, Object>();
    
    /* Fim Atributos */
    
    /* Construtores */
    public C3C_APP_ContractInterfaceApplication(){}    

    public Object newInstance(Object params)
    {
        System.debug(params);
        return (C3C_APP_ContractInterfaceApplication) JSON.deserialize((String) params, C3C_APP_ContractInterfaceApplication.class);
    }    
    /* Fim Construtores */
    
    /* Métodos */
    public void addNewReferencePagination(Object lastValue)
    {
        if(this.paginationAble != null && this.paginationAble)
            this.mapPagination.put(this.mapPagination.size()+2, lastValue);
    }
    
    public void addError(ErrorRating rating, String erroCode, String messageLabelOrText)
    {
        this.errors.add(new ErrorItem(String.valueOf(rating), erroCode, messageLabelOrText));
    }

    public void addWarning(WarningRating rating, String warningCode, String messageLabelOrText)
    {
        this.warnings.add(new WarningItem(String.valueOf(rating), warningCode, messageLabelOrText));
    }

    public void addPath(String className, String methodName, Map<String, Object> params, Object response)
    {
        this.path.add(new ExecutionItem(className, methodName, params, response));
    }

    public void checkIfError()
    {
        if(this.errors.size() == 0)
            this.status = String.valueOf(StatusCode.CompletedSuccess);
        else
            this.status = String.valueOf(StatusCode.CompletedError);
    }

    public void convertResponseToReturnType()
    {
        if(this.returnType != null)
        {
            if(this.response instanceOf List<Object>)
            {
                List<Object> responseResult = new List<Object>();
                
                for(Object resItem : (List<Object>) this.response)
                    responseResult.add((Object) C3C_DIContainer_Injector.newInstance(this.returnType, resItem));
                this.response = responseResult;
            }
            else
         		this.response = (Object) C3C_DIContainer_Injector.newInstance(this.returnType, this.response);       
        }
    }

    public void checkWarnings()
    {
        if(this.enabledWarning == false)
            this.warnings = new List<WarningItem>();
    }
	/* Fim Métodos */
    
    /* Classes e Enums */
    public class Body
    {
        @AuraEnabled public String service {get;set;}
        @AuraEnabled public String serviceMethod {get;set;}
        @AuraEnabled public Map<String, string> bodyMap {get;set;}
        
        public Body(String service, String serviceMethod, Map<String, string> body)
        {
            this.service = service;
            this.serviceMethod = serviceMethod;
            this.bodyMap = body;
        }
    }

    public class Pagination
    {
        @AuraEnabled public String fieldName {get;set;}
        @AuraEnabled public Object lastValue {get;set;}

        public Pagination(String fieldName, Object lastValue)
        {
            this.fieldName = fieldName;
            this.lastValue = lastValue;
        }
    }

    public class ExecutionItem
    {
        @AuraEnabled public String className {get;set;}
        @AuraEnabled public String methodName {get;set;}
        @AuraEnabled public Map<String, Object> params {get;set;}
        @AuraEnabled public Object response {get;set;}

        public ExecutionItem(String className, String methodName, Map<String, Object> params, Object response)
        {
            this.className = className;
            this.methodName = methodName;
            this.params = params;
            this.response = response;
        }
    }

    public class WarningItem
    {
        @AuraEnabled public String rating {get;set;}
        @AuraEnabled public String warningCode {get;set;}
        @AuraEnabled public String messageLabelOrText {get;set;}

        public WarningItem(String rating, String warningCode, String messageLabelOrText)
        {
            this.rating = rating;
            this.warningCode = warningCode;
            this.messageLabelOrText = messageLabelOrText;
        }
    }
    
    public class ErrorItem
    {
        @AuraEnabled public String rating {get;set;}
        @AuraEnabled public String erroCode {get;set;}
		@AuraEnabled public String messageLabelOrText {get;set;}

        public ErrorItem(String rating, String erroCode, String messageLabelOrText)
        {
            this.rating = rating;
            this.erroCode = erroCode;
            this.messageLabelOrText = messageLabelOrText;
        }
    }

    public enum StatusCode
    {
        InProgress, CompletedSuccess, CompletedError
    }

    public enum WarningRating
    {
		Low, Mid, High, Critical
    }
    
    public enum ErrorRating
    {
		Low, Mid, High, Critical
    }
    /* Fim e Enums */
}