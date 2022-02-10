/**
 * Created by Stanislaw Zan, zanstaszek9@gmail.com on 08.02.2022.
 */

@IsTest
private class VocativePolishFirstNameTest {

    @IsTest
    static void checkAgainstAllVocativesFromFile() {
        List<Contact> contacts = (List<Contact>) Test.loadData(Contact.SObjectType, 'imiona');
        for (Integer i = 0; i < 10; i++) {
            System.debug('%%% STZAN1 class: VocativePolishFirstNameTest, method: testBehavior; 2022-02-8, contacts: ' + contacts[i]);
        }
        Map<String, String> namesWithWrongVocative = new Map<String, String>();
        Integer count = 0;
        for (Contact  contact : contacts) {
            System.debug('%%% STZAN2 class: VocativePolishFirstNameTest, method: testBehavior; 2022-02-8,contact.FirstName: ' + contact.FirstName);

            VocativePolishFirstName nameWithVoc = new VocativePolishFirstName(contact.FirstName, '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>() );
            if (contact.LastName != nameWithVoc.getVocativeFirstName()){
                namesWithWrongVocative.put(contact.LastName, nameWithVoc.getVocativeFirstName());
            }
            if (++count > 50) {
                break;
            }
        }
        System.assert(namesWithWrongVocative.isEmpty(), 'Some vocatives were wrong: ' + JSON.serializePretty(namesWithWrongVocative));

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
}