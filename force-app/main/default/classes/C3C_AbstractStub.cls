public abstract class C3C_AbstractStub 
{
    public abstract String getClassName();
    
    public abstract Map<String, ClassTested> getMapClassTested();
    
    public Object handleMethodCall(
        Object stubbedObject, 
        String stubbedMethodName,
        Type returnType, 
        List<System.Type> listOfParamTypes, 
        List<String> listOfParamNames,
        List<Object> listOfArgs
    )
    {
        Object returnValue;
        
        String className = this.getClassName();
        
        Map<String, ClassTested> mapClassTested = this.getMapClassTested();
        ClassTested classe = mapClassTested.containsKey(className) ? mapClassTested.get(className) : new ClassTested(className);
        
        returnValue = this.methodCall(
            stubbedObject,
            stubbedMethodName,
            returnType,
            listOfParamTypes,
            listOfParamNames,
            listOfArgs
        );
        
        classe.addMethod(
            stubbedMethodName,
            listOfParamNames,
            listOfArgs,
            returnType,
            returnValue
        );
        
        mapClassTested.put(
            className,
            classe
        );
        
        return returnValue;
    }
    
    public virtual Object methodCall(
        Object stubbedObject, 
        String stubbedMethodName,
        Type returnType, 
        List<System.Type> listOfParamTypes, 
        List<String> listOfParamNames,
        List<Object> listOfArgs
    )
    {
        return null;
    }
}