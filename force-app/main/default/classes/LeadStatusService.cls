public with sharing class LeadStatusService implements ILeadStatusService
{
    public class NenhumLeadStatusRetornadoException extends Exception {}
    private ILeadStatusSelector instanciaLeadStatusSelector
    {
        get
        {
            if(this.instanciaLeadStatusSelector == null)
                this.instanciaLeadStatusSelector = (ILeadStatusSelector) C3C_DIContainer_Injector.getInstance('LeadStatusSelector');

            return this.instanciaLeadStatusSelector;
        }
        set;
    }

    public String retornarLabelDeLeadConvertido()
    {
        try 
        {
            for(SObject leadStatusObj : this.instanciaLeadStatusSelector.buscarLeadStatusDeStatusConvertido())
            {
                ILeadStatusDomain leadStatusDomain = (ILeadStatusDomain) C3C_DIContainer_Injector.newInstance('LeadStatusDomain', leadStatusObj);
                return leadStatusDomain.pegarMasterLabel();
            }
            throw new NenhumLeadStatusRetornadoException('Nenhum LeadStatus foi retornado na no chamado da classe LeadStatusService!');
        } 
        catch (Exception e) 
        {
            System.debug(e.getMessage());
            return null;
        }
    }
}