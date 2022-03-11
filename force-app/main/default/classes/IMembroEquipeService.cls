public interface IMembroEquipeService 
{
    List<MembroEquipeMapper> obterMembroEquipePorEquipes(List<String> listaEquipes);
    List<MembroEquipeMapper> obterMembroEquipePorListaIdEquipe(List<String> listaIdEquipe);
}