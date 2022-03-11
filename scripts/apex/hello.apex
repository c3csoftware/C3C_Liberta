// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

InstanciaRespostaService irs = new InstanciaRespostaService();
try {
    irs.verificarPopAssessorRespondido('00Q8G000002XsB5UAK');
    System.debug('Rodou');
} catch (Exception e) {
    if(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'))
        System.debug(e.getMessage().split('FIELD_CUSTOM_VALIDATION_EXCEPTION,')[1].split(': \\[\\]')[0]);
    else if(e.getMessage().contains('DUPLICATE_VALUE'))
        System.debug(e.getMessage().split('DUPLICATE_VALUE,')[1]);
    else if(e.getMessage().contains('CANNOT_UPDATE_CONVERTED_LEAD'))
        System.debug(e.getMessage().split('CANNOT_UPDATE_CONVERTED_LEAD')[1]);
    else
    {
        System.debug('tiago é lindo');
        System.debug(e.getMessage());

    }
        
}


