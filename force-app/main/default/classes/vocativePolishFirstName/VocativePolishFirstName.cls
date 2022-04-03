/**
 * VocativePolishFirstName
 *
 * Component for remake first name to Polish vocative
 *
 * @author  Mariusz Mielnik <mariusz@ecbox.pl>
 * @author  Stanislaw Zan <zanstaszek9@gmail.com>
 * @license  MIT
 *
 */


public class VocativePolishFirstName {

    /**
     * @description
     * @param first_name
     * @param titles
     * @param exceptions
     **/
    public VocativePolishFirstName(String first_name, Map<GENDER, String> titles, Map<String, VocativePerson> exceptions) {
        if (!titles.isEmpty()) {
            this.setTitles(titles);
        }

        if (!exceptions.isEmpty()) {
            this.exceptionsToVocativeRules.putAll(exceptions);
        }

        this.remakeToVocative(first_name);
    }

    /**
     * @description
     * @param first_name
     **/
    public VocativePolishFirstName(String first_name) {
        this(first_name, new Map<GENDER, String>(), new Map<String, VocativePerson>());
    }

    /**
     * @description Return default titles definition
     *
     * @return array
     */
    public Map<GENDER, String> getTitles() {
        return this.titles.get('default');
    }

    /**
     * @description Returns titles definition by group name
     *
     * @param aGroup
     *
     * @return Map<String, String>
     */
    public Map<GENDER, String> getTitlesByGroup(String aGroup) {
        return this.titles.get(aGroup);
    }

    /**
     * @description Setup own titles like Mr&#47; Mrs, Panie&#47;Pani
     * <p/>
     * for english ex. ['GENDER.UNDEFINABLE => 'Mr. &#47; Mrs.', GENDER.MAN => 'Mrs.', GENDER.WOMAN => 'Mr.'];
     * <p/>
     * for polish ex. ['GENDER.UNDEFINABLE => 'Mr. &#47; Mrs.', GENDER.MAN => 'Szanowny Panie', GENDER.WOMAN => 'Szanowna Pani'];
     * <p/>
     * For multiple titles definitions use group name
     * <p/>
     * for polish ex. group: 'default' => ['GENDER.UNDEFINABLE => 'Panie &#47;  Pani', GENDER.MAN => 'Panie', GENDER.WOMAN => 'Pani'];
     * <p/>
     * for polish ex. group: 'polite' => ['GENDER.UNDEFINABLE => '', GENDER.MAN => 'Szanowny Panie', GENDER.WOMAN => 'Szanowna Pani'];
     *
     * @param titles
     **/
    public void setTitles(Map<GENDER, String> titles) {
        setTitles(titles, 'default');
    }

    /**
     * @description Setup own titles like Mr&#47; Mrs, Panie&#47;Pani
     * <p/>
     * for english ex. [GENDER.UNDEFINABLE => '', GENDER.MAN => 'Mrs.', GENDER.WOMAN => 'Mr.'];
     * <p/>
     * for polish ex. [GENDER.UNDEFINABLE => '', GENDER.MAN => 'Szanowny Panie', GENDER.WOMAN => 'Szanowna Pani'];
     * <p/>
     * For multiple titles definitions use group name
     * <p/>
     * for polish ex. group: 'default' => [GENDER.UNDEFINABLE => 'Panie &#47;  Pani', GENDER.MAN => 'Panie', GENDER.WOMAN => 'Pani'];
     * <p/>
     * for polish ex. group: 'polite' => [GENDER.UNDEFINABLE => '', GENDER.MAN => 'Szanowny Panie', GENDER.WOMAN => 'Szanowna Pani'];
     *
     * @param titles
     * @param aGroup
     */
    public void setTitles(Map<GENDER, String> titles, String aGroup) {
        this.titles.put(aGroup, titles);
    }


    /**
     * @description Returns array with vocative firs name and gender.
     *
     * @return VocativePerson
     */
    public VocativePerson getVocativePerson() {
        return this.vocativePerson;
    }

    /**
     * @description Returns vocative first name
     *
     * @return string
     */
    public String getFirstNameInVocative() {
        return this.vocativePerson.vocative;
    }

    /**
     * @description Returns title for a given Group that has been previously defined
     *
     * @param aGroup
     *
     * @return String
     */
    public String getDetectedTitle(String aGroup) {
        return this.titles.get(aGroup).get(this.vocativePerson.getDetectedGender());
    }

    /**
     * @description Returns title for default settings
     *
     * @return string
     */
    public String getDetectedTitle() {
        return this.getDetectedTitle('default');
    }

    /**
     * @description Returns gender M - Male, W - Woman, U - Unknown
     *
     * @return string
     */
    public GENDER getDetectedGender() {
        return this.vocativePerson.getDetectedGender();
    }


    /**
     * @description Returns true if first name belongs to man
     *
     * @return bool
     */
    public Boolean isMan() {
        return this.vocativePerson.isMan();
    }

    /**
     * @description Returns true if first name belongs to woman
     *
     * @return bool
     */
    public Boolean isWoman() {
        return this.vocativePerson.isWoman();
    }

    /**
     * @description Returns true if gender cannot be defined by first name
     *
     * @return bool
     */
    public Boolean isUndefinable() {
        return this.vocativePerson.isUndefinable();
    }

    /**
     * @description Returns true if first name are made up from names of multiple people
     *
     * @return bool
     */
    public Boolean isPlural() {
        return this.vocativePerson.isPlural();
    }

    /**
     * @description Return vocative first name with title
     *
     * @param delimiter default ' ' (space)
     * @param aGroup group
     *
     * @return string
     */
    public String getVocativeStringWithTitle(String delimiter, String aGroup) {
        return this.getDetectedTitle(aGroup) + delimiter + this.getFirstNameInVocative();
    }

    /**
     * @description Return vocative first name with title, with specified delimiter and default Group
     *
     * @param delimiter
     *
     * @return String
     */
    public String getVocativeStringWithTitle(String delimiter) {
        return getVocativeStringWithTitle(delimiter, 'default');
    }

    /**
     * @description Return vocative first name with title, with delimiter of Space and default Group
     *
     * @return String
     */
    public String getVocativeStringWithTitle() {
        return getVocativeStringWithTitle(' ', 'default');
    }

    /**
     * @description Convert name to make every first letter up, split by character type
     *
     * @param name
     *
     * @return string
     */
    public static String nameCaseConvert(String name) {
        String output = '';
        for (String str : name.toLowerCase().splitByCharacterTypeCamelCase()) {
            output += str.capitalize();
        }
        return output;
    }


    /**
     * @description
     * @param first_name
     *
     * @return VocativePerson
     *
     * @throws VocativePolishFirstNameException
     */
    private VocativePerson checkExceptions(String first_name) {
        final VocativePerson nameWithException = this.exceptionsToVocativeRules.get(first_name);
        if (nameWithException == null) {
            return null;
        }

        if (!nameWithException.hasDefinedVocativeAndGender()) {
            throw new VocativePolishFirstNameException('Invalid format - exception to the rules of firstname must have specified gender and vocative form.');
        }

        switch on nameWithException.getDetectedGender() {
            when MAN, WOMAN, UNDEFINABLE, PLURAL {
                return nameWithException;
            }
            when else {
                throw new VocativePolishFirstNameException('Undefined gender');
            }
        }

    }


    /**
     * @description Remake first name to Polish vocative
     *
     * @param firstname firstname
     *
     * @throws VocativePolishFirstNameException
     */
    public void remakeToVocative(String firstname) {
        if (String.isBlank(firstname)) {
            throw new VocativePolishFirstNameException('First name cannot be empty');
        }

        if (this.vocativePerson != null) {
            return;
        }

        firstname = nameCaseConvert(firstname).trim();
        final VocativePerson creatingVocative = new VocativePerson(firstname);
        this.vocativePerson = creatingVocative;

        processAndAddNamePartsToVocative(firstname, creatingVocative);
    }

    private void processAndAddNamePartsToVocative(final String firstname, final VocativePerson creatingVocative) {
        for (String partOfName : firstname.splitByCharacterTypeCamelCase()) {
            final VocativePerson tempVocative = this.checkExceptions(partOfName);
            if (isInExceptionList(tempVocative)) {
                this.vocativePerson = tempVocative;
                return;
            }

            if (isSpaceOrDelimiterOrConjunction(partOfName.length())) {
                creatingVocative.attachConjunction(partOfName.toLowerCase());
                continue;
            }

            try {
                findAndUseMatchingRule(partOfName, creatingVocative);
            }
            catch (StringException e) {
                throw new VocativePolishFirstNameException('An error with name ' + partOfName + ':  ' + e, e);
            }
        }
    }

    private void findAndUseMatchingRule(String partOfName, VocativePerson creatingVocative) {
        for (VocativeRule vocativeRule : VocativeRule.vocativeRules) {
            if (vocativeRule.isEndingMatching(partOfName)) {
                creatingVocative.attachToVocativePerson(partOfName, vocativeRule);
                return;
            }
        }
    }

    private Boolean isInExceptionList(VocativePerson tempVocative) {
        return tempVocative != null;
    }

    private Boolean isSpaceOrDelimiterOrConjunction(Integer partOfName) {
        final Integer maxDelimiterLength = 1;
        return partOfName <= maxDelimiterLength;
    }



    public enum GENDER {UNDEFINABLE, MAN, WOMAN, PLURAL}

    /**
     * @description Polish definitions array for default group
     * <p/>
     *      GENDER.PLURAL => 'Państwo', <br/>
     *      GENDER.UNDEFINABLE => 'Panie &#47; Pani', <br/>
     *      GENDER.MAN => 'Panie', <br/>
     *      GENDER.WOMAN => 'Pani' <br/>
     */
    private final Map<String, Map<GENDER, String>> titles = new Map<String, Map<GENDER, String>>{
            'default' => new Map<GENDER, String>{
                    GENDER.PLURAL => 'Państwo',
                    GENDER.UNDEFINABLE => 'Panie/Pani',
                    GENDER.MAN => 'Panie',
                    GENDER.WOMAN => 'Pani'
            }
    };

    private VocativePerson vocativePerson;

    /**
     * @description List of names that are exceptions to the general rules
     */
    public final Map<String, VocativePerson> exceptionsToVocativeRules = new Map<String, VocativePerson>{
            'Ola' => new VocativePerson('Ola', GENDER.WOMAN, 'Olu'),
            'Saba' => new VocativePerson('Saba', GENDER.WOMAN, 'Sabo'),
            'Noemi' => new VocativePerson('Noemi', GENDER.WOMAN, 'Noemi'),
            'Sonia' => new VocativePerson('Sonia', GENDER.WOMAN, 'Soniu'),
            'Luba' => new VocativePerson('Luba', GENDER.WOMAN, 'Lubo'),
            'Jeremi' => new VocativePerson('Jeremi', GENDER.MAN, 'Jeremi'),
            'Kirył' => new VocativePerson('Kirył', GENDER.MAN, 'Kiryle'),
            'Miriam' => new VocativePerson('Miriam', GENDER.WOMAN, 'Miriam'),
            'Margot' => new VocativePerson('Margot', GENDER.WOMAN, 'Margot'),
            'Ingrid' => new VocativePerson('Ingrid', GENDER.WOMAN, 'Ingrid'),
            'Lew' => new VocativePerson('Lew', GENDER.MAN, 'Lwie'),
            'Narcyz' => new VocativePerson('Narcyz', GENDER.MAN, 'Narcyzie'),
            'Kosma' => new VocativePerson('Kosma', GENDER.MAN, 'Kosmo'),
            'Bonawentura' => new VocativePerson('Bonawentura', GENDER.MAN, 'Bonawenturo'),
            'Carmen' => new VocativePerson('Carmen', GENDER.WOMAN, 'Carmen'),
            'Doris' => new VocativePerson('Doris', GENDER.WOMAN, 'Doris'),
            'Dolores' => new VocativePerson('Dolores', GENDER.WOMAN, 'Dolores'),
            'Abigail' => new VocativePerson('Abigail', GENDER.WOMAN, 'Abigail'),
            'Nikolett' => new VocativePerson('Nikolett', GENDER.WOMAN, 'Nikoletto'),
            'Ania' => new VocativePerson('Ania', GENDER.WOMAN, 'Aniu')
    };
}