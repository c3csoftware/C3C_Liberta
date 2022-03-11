public interface ILeadTriggerAfterInsertService 
{
    // Método responponsável por converter leads em conta, caso esteja na base.
    void converterLeadCasoPossuaContaNaBase(List<ILeadDomain> listaLeadDomain);
}