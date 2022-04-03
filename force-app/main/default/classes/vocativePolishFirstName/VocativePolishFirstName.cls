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
    public final Map<String, VocativePerson> exceptions = new Map<String, VocativePerson>{
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
            this.exceptions.putAll(exceptions);
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
    public String getVocativeFirstName() { //TODO: Change name
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
        return this.titles.get(aGroup).get(this.vocativePerson.gender);
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
        return this.vocativePerson.gender;
    }


    /**
     * @description Returns true if first name belongs to man
     *
     * @return bool
     */
    public Boolean isMan() {
        if (this.vocativePerson.gender == GENDER.MAN) {
            return true;
        }

        return false;
    }

    /**
     * @description Returns true if first name belongs to woman
     *
     * @return bool
     */
    public Boolean isWoman() {
        if (this.vocativePerson.gender == GENDER.WOMAN) {
            return true;
        }

        return false;
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
        return this.getDetectedTitle(aGroup) + delimiter + this.getVocativeFirstName();
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
        final VocativePerson nameWithException = this.exceptions.get(first_name);
        if (nameWithException == null) {
            return null;
        }

        if (!nameWithException.hasDefinedVocativeAndGender()) {
            throw new VocativePolishFirstNameException('Invalid format - exception to the rules of firstname must have specified gender and vocative form.');
        }

        switch on nameWithException.gender {
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
        for (VocativeRule vocativeRule : vocativeRules) {
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


    public class VocativeRule {
        public Set<String> nameEndings;
        public GENDER gender;
        public Integer replaceFromRight;
        public String vocativeSuffix;

        /**
         * @description
         * @param nameEnding The last letters from tha name that allows to assume Vocative form
         * @param gender A gender to assume
         * @param replaceFromRight Amount of letters to chop from right
         * @param vocativeSuffix Suffix to add to the end of string
         **/
        public VocativeRule(String nameEnding, GENDER gender, Integer replaceFromRight, String vocativeSuffix) {
            this(new Set<String>{nameEnding}, gender, replaceFromRight, vocativeSuffix);
        }

        /**
         * @description
         * @param nameEndings A group of the last letters from tha name that allows to assume Vocative form for all endings
         * @param gender A gender to assume
         * @param replaceFromRight Amount of letters to chop from right
         * @param vocativeSuffix Suffix to add to the end of string
         **/
        public VocativeRule(Set<String> nameEndings, GENDER gender, Integer replaceFromRight, String vocativeSuffix) {
            this.nameEndings = nameEndings;
            this.gender = gender;
            this.replaceFromRight = replaceFromRight;
            this.vocativeSuffix = vocativeSuffix;
        }

        public Boolean isEndingMatching(final String firstname) {
            return VPFN_StringUtils.endsWithAnySpecifiedIgnoreCase(firstname, this.nameEndings);
        }

        /**
         * @description Return the actual Vocative form
         * @param firstname
         *
         * @return Actual Vocative form
         **/
        public String getVocativeName(final String firstname) {
            return (VPFN_StringUtils.chopString(firstname, this.replaceFromRight)) + vocativeSuffix;
        }

    }

    /**
     * @description List of Vocative Rules with lazy-loading
     **/
    public static List<VocativeRule> vocativeRules {
        public get {
            if (vocativeRules == null) {
                vocativeRules = new List<VocativeRule>();
                populateVocativeRules();
            }
            return vocativeRules;
        }
        private set;
    }

    /**
     * @description Defined rules that should cover all standard Polish vocatives
     **/
    public static void populateVocativeRules() {
        vocativeRules.add(new VocativeRule(new Set<String>{
                'ni', 'li', 'zi'
        }, GENDER.MAN, 0, ''));
        vocativeRules.add(new VocativeRule('eł', GENDER.MAN, 2, 'le'));
        vocativeRules.add(new VocativeRule('ił', GENDER.MAN, 1, 'le'));
        vocativeRules.add(new VocativeRule('et', GENDER.MAN, 1, 'cie'));
        vocativeRules.add(new VocativeRule('tr', GENDER.MAN, 0, 'ze'));
        vocativeRules.add(new VocativeRule('ał', GENDER.MAN, 1, 'le'));
        vocativeRules.add(new VocativeRule(new Set<String>{'it', 'rt'}, GENDER.MAN, 1, 'cie'));
        vocativeRules.add(new VocativeRule('ciek', GENDER.MAN, 4, 'ćku'));
        vocativeRules.add(new VocativeRule('siek', GENDER.MAN, 4, 'śku'));
        vocativeRules.add(new VocativeRule('niec', GENDER.MAN, 4, 'ńcu'));
        vocativeRules.add(new VocativeRule('per', GENDER.MAN, 2, 'rze'));
        vocativeRules.add(new VocativeRule(new Set<String>{'ek', 'ko'}, GENDER.MAN, 2, 'ku'));
        vocativeRules.add(new VocativeRule('st', GENDER.MAN, 2, 'ście'));
        vocativeRules.add(new VocativeRule('sł', GENDER.MAN, 2, 'śle'));
        vocativeRules.add(new VocativeRule(new Set<String>{'cja', 'ria', 'lia', 'dia', 'wia', 'fia', 'iela', 'bela', 'zula', 'saba'}, GENDER.WOMAN, 1, 'o'));
        vocativeRules.add(new VocativeRule(new Set<String>{'iola', 'rola'}, GENDER.WOMAN, 1, 'u'));
        vocativeRules.add(new VocativeRule(new Set<String>{'aja', 'sia'}, GENDER.WOMAN, 1, 'u'));
        vocativeRules.add(new VocativeRule(new Set<String>{'ja', 'ia', 'la'}, GENDER.WOMAN, 1, 'o'));
        vocativeRules.add(new VocativeRule('ba', GENDER.MAN, 1, 'o'));
        vocativeRules.add(new VocativeRule(new Set<String>{'oe', 'ue'}, GENDER.MAN, 0, ''));
        vocativeRules.add(new VocativeRule('oń', GENDER.MAN, 1, 'niu'));
        vocativeRules.add(new VocativeRule(new Set<String>{'n', 'f', 'm', 'w', 'p', 's', 'b'}, GENDER.MAN, 0, 'ie'));
        vocativeRules.add(new VocativeRule('bel', GENDER.MAN, 3, 'ble'));
        vocativeRules.add(new VocativeRule('ez', GENDER.WOMAN, 0, ''));
        vocativeRules.add(new VocativeRule(new Set<String>{'g', 'h', 'j', 'k', 'l', 'z'}, GENDER.MAN, 0, 'u'));
        vocativeRules.add(new VocativeRule('der', GENDER.MAN, 2, 'rze'));
        vocativeRules.add(new VocativeRule('ster', GENDER.MAN, 2, 'rze'));
        vocativeRules.add(new VocativeRule('r', GENDER.MAN, 0, 'ze'));
        vocativeRules.add(new VocativeRule('d', GENDER.MAN, 0, 'zie'));
        vocativeRules.add(new VocativeRule('a', GENDER.WOMAN, 1, 'o'));
        vocativeRules.add(new VocativeRule('e', GENDER.WOMAN, 0, ''));
        vocativeRules.add(new VocativeRule('y', GENDER.MAN, 0, ''));
        vocativeRules.add(new VocativeRule('o', GENDER.MAN, 0, ''));
        vocativeRules.add(new VocativeRule('t', GENDER.MAN, 1, 'cie'));
        vocativeRules.add(new VocativeRule('', GENDER.UNDEFINABLE, 0, '')); //TODO Test czy nameEnding pusty jest TRUE
    }
}