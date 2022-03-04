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
            final VocativePolishFirstName nameWithVoc = new VocativePolishFirstName(contact.FirstName, '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() );
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
    static void shouldProcessCorrectlyOnPolishDiacritics() {
        System.assertEquals('Bogusądzie', new VocativePolishFirstName('Bogusąd', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() ).getVocativeFirstName());
        System.assertEquals('Więcemile', new VocativePolishFirstName('Więcemił', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() ).getVocativeFirstName());
        System.assertEquals('Kiryle', new VocativePolishFirstName('Kirył', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() ).getVocativeFirstName());
        System.assertEquals('Czechoniu', new VocativePolishFirstName('Czechoń', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() ).getVocativeFirstName());
        System.assertEquals('Mściwóju', new VocativePolishFirstName('Mściwój', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() ).getVocativeFirstName());
        System.assertEquals('Świętopełku', new VocativePolishFirstName('Świętopełk', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() ).getVocativeFirstName());
        System.assertEquals('Andżeliko', new VocativePolishFirstName('Andżelika', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() ).getVocativeFirstName());


    }

    @IsTest
    static void shouldReturnProperTitlesForDefaultSexes() {
        System.assert(new VocativePolishFirstName('Krzysztof', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getVocativeStringWithTitle().startsWith('Panie'));
        System.assert(new VocativePolishFirstName('Alicja', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getVocativeStringWithTitle().startsWith('Pani'));
        System.assert(new VocativePolishFirstName('Maliq', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getVocativeStringWithTitle().startsWith('Panie/Pani'));
    }

    @IsTest
    static void shouldReturnProperGender() {
        System.assertEquals('M', new VocativePolishFirstName('Krzysztof', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getDetectedGender());
        System.assertEquals('W', new VocativePolishFirstName('Alicja', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getDetectedGender());
        System.assertEquals('U', new VocativePolishFirstName('Maliq', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getDetectedGender());
    }

    @IsTest
    static void shouldReturnTrueForMaleName() {
        System.assert(new VocativePolishFirstName('Krzysztof', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).isMan());

    }

    @IsTest
    static void shouldReturnTrueForFemaleName() {
        System.assert(new VocativePolishFirstName('Alicja', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).isWoman());
    }


    @IsTest
    static void shouldCapitalizeDoubleName() {
        System.assertEquals('Jan Krzysztof', VocativePolishFirstName.nameCaseConvert('jan krzysztof'));
    }


    @IsTest
    static void shouldProcessDoubleBarreledName() {
        System.assertEquals('Janie-Krzysztofie', new VocativePolishFirstName('Jan-Krzysztof', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getVocativeFirstName());
    }

    @IsTest
    static void shouldProcessDoubleName() {
        System.assertEquals('Janie Mario', new VocativePolishFirstName('Jan Maria', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getVocativeFirstName());
    }

    @IsTest
    static void shouldProcessTwoNamesWithConjunction() {
        // TODO: Assume Undefined gender
        System.assertEquals('Janie i Mario', new VocativePolishFirstName('Jan i Maria', '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>()).getVocativeFirstName());
    }
}