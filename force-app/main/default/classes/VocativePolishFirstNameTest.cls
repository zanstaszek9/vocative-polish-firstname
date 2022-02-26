/**
 * Created by Stanislaw Zan, zanstaszek9@gmail.com on 08.02.2022.
 */

@IsTest
private class VocativePolishFirstNameTest {

    @IsTest
    static void checkAgainstAllVocativesFromFile() {
        final Map<String, String> namesWithWrongVocative = new Map<String, String>();
        //given
        final List<Contact> contacts = (List<Contact>) Test.loadData(Contact.SObjectType, 'imiona');

        //when
        for (Contact  contact : contacts) {
            final VocativePolishFirstName nameWithVoc = new VocativePolishFirstName(contact.FirstName, '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() );
            if (contact.LastName != nameWithVoc.getVocativeFirstName()){
                namesWithWrongVocative.put(contact.LastName, nameWithVoc.getVocativeFirstName());
            }
        }
        //then
        System.assert(namesWithWrongVocative.isEmpty(), namesWithWrongVocative.size() + ' vocatives were wrong: ' + namesWithWrongVocative);
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

}