public interface ILigacaoL5Domain 
{
    LigacaoL5Mapper obterMapper(); //Responsável por retornar a mapper
    SObject obterRegistro(); //Responsável por retornar o registro SObject
}