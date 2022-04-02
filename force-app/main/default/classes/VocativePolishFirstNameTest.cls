/**
 * Created by Stanislaw Zan, zanstaszek9@gmail.com on 08.02.2022.
 */

@IsTest
private class VocativePolishFirstNameTest {

    @IsTest
    static void checkAgainstAllVocativesFromFile() {
        final Map<String, String> namesWithWrongVocative = new Map<String, String>();
        final Map<String, String> namesWithWrongGender = new Map<String, String>();
        //given
        final List<Contact> contacts = (List<Contact>) Test.loadData(Contact.SObjectType, 'imiona');

        //when
        for (Contact  contact : contacts) {
            final VocativePolishFirstName nameWithVoc = new VocativePolishFirstName(contact.FirstName);
            if (contact.LastName != nameWithVoc.getVocativeFirstName()){
                namesWithWrongVocative.put(contact.LastName, nameWithVoc.getVocativeFirstName());
            }
            if (contact.Gender__c != nameWithVoc.getDetectedGender()){
                namesWithWrongGender.put(contact.Gender__c, nameWithVoc.getDetectedGender());
            }
        }
        //then
        System.assert(namesWithWrongVocative.isEmpty(), namesWithWrongVocative.size() + ' vocatives were wrong: ' + namesWithWrongVocative);
        System.assert(namesWithWrongGender.isEmpty(), namesWithWrongGender.size() + ' genders were wrong: ' + namesWithWrongGender);
    }

    @IsTest
    static void test2() {
        //TODO: Export the tested method and Test to another class, like String.Utils STZAN
        System.assert(VocativePolishFirstName.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'a'}));
        System.assert(!VocativePolishFirstName.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'b'}));
        System.assert(VocativePolishFirstName.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'b', 'a'}));
        System.assert(VocativePolishFirstName.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {''}));
        System.assert(!VocativePolishFirstName.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'longerThanName'}));

    }

    @IsTest
    static void test3(){
        //TODO: Export the tested method and Test to another class, like String.Utils STZAN
        System.assertEquals('A', VocativePolishFirstName.chopString('Ada', 2));
    }

    @IsTest
    static void shouldProcessCorrectlyOnPolishDiacritics() {
        System.assertEquals('Bogusądzie', new VocativePolishFirstName('Bogusąd').getVocativeFirstName());
        System.assertEquals('Więcemile', new VocativePolishFirstName('Więcemił').getVocativeFirstName());
        System.assertEquals('Kiryle', new VocativePolishFirstName('Kirył').getVocativeFirstName());
        System.assertEquals('Czechoniu', new VocativePolishFirstName('Czechoń').getVocativeFirstName());
        System.assertEquals('Mściwóju', new VocativePolishFirstName('Mściwój').getVocativeFirstName());
        System.assertEquals('Świętopełku', new VocativePolishFirstName('Świętopełk').getVocativeFirstName());
        System.assertEquals('Andżeliko', new VocativePolishFirstName('Andżelika').getVocativeFirstName());


    }

    @IsTest
    static void shouldReturnProperTitlesForDefaultSexes() {
        System.assert(new VocativePolishFirstName('Krzysztof').getVocativeStringWithTitle().startsWith('Panie'));
        System.assert(new VocativePolishFirstName('Alicja').getVocativeStringWithTitle().startsWith('Pani'));
        System.assert(new VocativePolishFirstName('Maliq').getVocativeStringWithTitle().startsWith('Panie/Pani'));
    }

    @IsTest
    static void shouldReturnProperGender() {
        System.assertEquals('M', new VocativePolishFirstName('Krzysztof').getDetectedGender());
        System.assertEquals('W', new VocativePolishFirstName('Alicja').getDetectedGender());
        System.assertEquals('U', new VocativePolishFirstName('Maliq').getDetectedGender());
    }

    @IsTest
    static void shouldReturnProperGenderForDoubleNames() {
        System.assertEquals('M', new VocativePolishFirstName('Jan-Krzysztof').getDetectedGender());
        System.assertEquals('W', new VocativePolishFirstName('Anna-Alicja').getDetectedGender());
        System.assertEquals('M', new VocativePolishFirstName('Jan Maria').getDetectedGender());
        System.assertEquals('W', new VocativePolishFirstName('Maria Jan').getDetectedGender());
    }

    @IsTest
    static void shouldReturnProperGenderTwoNames() {
        System.assertEquals('G', new VocativePolishFirstName('Tomasz i Julia').getDetectedGender());
        System.assertEquals('G', new VocativePolishFirstName('Julia i Tomasz').getDetectedGender());
    }


    @IsTest
    static void shouldReturnTrueForMaleName() {
        System.assert(new VocativePolishFirstName('Krzysztof').isMan());

    }

    @IsTest
    static void shouldReturnTrueForFemaleName() {
        System.assert(new VocativePolishFirstName('Alicja').isWoman());
    }


    @IsTest
    static void shouldCapitalizeDoubleName() {
        System.assertEquals('Jan Krzysztof', VocativePolishFirstName.nameCaseConvert('jan krzysztof'));
    }


    @IsTest
    static void shouldProcessDoubleBarreledName() {
        System.assertEquals('Janie-Krzysztofie', new VocativePolishFirstName('Jan-Krzysztof').getVocativeFirstName());
    }

    @IsTest
    static void shouldProcessDoubleName() {
        System.assertEquals('Janie Mario', new VocativePolishFirstName('Jan Maria').getVocativeFirstName());
    }

    @IsTest
    static void shouldProcessTwoNamesWithConjunction() {
        // TODO: Assume Undefined gender
        System.assertEquals('Janie i Mario', new VocativePolishFirstName('Jan i Maria').getVocativeFirstName());
    }
}