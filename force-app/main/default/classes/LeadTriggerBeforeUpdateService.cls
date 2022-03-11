public without sharing class LeadTriggerBeforeUpdateService implements ILeadTriggerBeforeUpdateService
{
    public void atualizarLeads(List<ILeadDomain> listaLeadDomain)
    {
        for(ILeadDomain leadDomain : listaLeadDomain)
        {
            LeadMapper leadMpp = leadDomain.obterMapper();
            if(leadMpp.sobrenome != null)
            {
                if(leadMpp.sobrenome.contains('one]'))
                    leadMpp.sobrenome = '⠀';
            }
            if(leadMpp.empresa != null)
            {
                if(leadMpp.empresa.contains('one]'))
                    leadMpp.empresa = '⠀';
            }
        }

    }
}