@isTest
public class MethodTested {
    public List<String> listOfParamNames {get;private set;}
    public List<Object> listOfArgs {get;private set;}
    public String methodName {get;private set;}
    public Type returnType {get;private set;}
    public Object returnValue {get;private set;}
    
    public MethodTested(
        String methodName,
        List<String> listOfParamNames,
        List<Object> listOfArgs,
        Type returnType,
        Object returnValue
    ) {
        this.methodName = methodName;
        this.listOfParamNames = listOfParamNames;
        this.listOfArgs = listOfArgs;
        this.returnType = returnType;
        this.returnValue = returnValue;
    }
}