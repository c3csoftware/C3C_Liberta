public  interface ILeadShareService 
{
    List<LeadShareDomain> obterCompartilhamentoLeadComIdsLead(Set<String> leadIds); //Responsável por obter os compartilahmentos do Lead com ids de Lead
    Map<String, String> obterMapaCompartilhamentoLeadUsuarioHunter(Set<String> leadIds); //Responsável por obter um mapa de compartilhamento de lead com usuário Hunter
}