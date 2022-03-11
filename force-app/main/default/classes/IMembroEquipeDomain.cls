public interface IMembroEquipeDomain 
{
    MembroEquipeMapper construirMembroEquipeMapper(SObject membroEquipe);
    List<MembroEquipeMapper> construirListMembroEquipeMapper(List<SObject> listMembroEquipe);
}