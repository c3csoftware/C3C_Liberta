public interface IAlterarStatusLeadService
{
    void mudarStatusLead(Map<String, Object> mapaIdLeadComStatus);
    void mudarStatusLeadNovoParaPrimeiroContato(Map<String, Object> mapaIdLeadComStatus);
}