public interface IMembroEquipeSelector 
{
    List<SObject> obterMembroEquipePorEquipes(List<String> listaEquipes);
    List<SObject> obterMembroEquipePorListaIdEquipe(List<String> listaIdEquipe);
    List<SObject> obterMembroEquipePorUsuarioId(String idUsuario);
}