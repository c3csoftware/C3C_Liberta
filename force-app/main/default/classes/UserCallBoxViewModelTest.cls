@isTest
public with sharing class UserCallBoxViewModelTest 
{
    @isTest 
    static void testeNewInstance()
    {
        new UserCallBoxViewModel().newInstance((IUserDomain) C3C_DIContainer_Injector.newInstance('UserDomain'));
    }
}