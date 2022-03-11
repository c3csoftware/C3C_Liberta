public interface IConvertorLeadParaConta
{
    // Método responponsável por converter leads em conta, caso esteja na base.
    void converterLeadCasoPossuaContaNaBase(List<ILeadDomain> listaLeadDomain);
}