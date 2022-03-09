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
     * Structure to hold name, sex and vocative
     *
     *
     */
    public class VocativeSex { //TODO: Change name
        public final String denominatorName;
        public String sex;
        public String vocative = '';

        /**
         * @param denominatorName name in denominator (pl. mianownik) form
         * @param sex sex indication in form of letters, 'U' for 'Unable to define', 'W' for Woman, 'M' for Man
         * @param vocative name in vocative (pl. wołacz) form
         **/
        public VocativeSex(String denominatorName, String sex, String vocative) {
            this.denominatorName = denominatorName;
            this.sex = sex;
            this.vocative = vocative;
        }

        public Boolean hasDefinedVocativeAndSex() {
            return String.isNotBlank(this.vocative) && String.isNotBlank(this.sex);
        }

        public void attachToVocativeSex(String denominatorName, String sex, String vocative) {
            this.sex = (String.isBlank(this.sex)) ? this.sex = sex : this.sex;
            this.vocative += vocative;
        }
    }


    /**
     * Polish definitions array for default group
     *
     * U = Unable to define
     * M = Male
     * W = Woman
     *
     */
    private final Map<String, Map<String, String>> titles = new Map<String, Map<String, String>>{
            'default' => new  Map<String, String>{
                    'U' => 'Panie/Pani',
                    'M' => 'Panie',
                    'W' => 'Pani'
            }
    };

    private VocativeSex vocative;

    private String encoding;

    /**
     * @description List of exceptions
     *
     */
    public final Map<String, VocativeSex> exceptions = new Map<String, VocativeSex>{
            'Ola' => new VocativeSex('Ola', 'W', 'Olu'),
            'Saba' => new VocativeSex('Saba', 'W', 'Sabo'),
            'Noemi' => new VocativeSex('Noemi', 'W', 'Noemi'),
            'Sonia' => new VocativeSex('Sonia', 'W', 'Soniu'),
            'Luba' => new VocativeSex('Luba', 'W', 'Lubo'),
            'Jeremi' => new VocativeSex('Jeremi', 'M', 'Jeremi'),
            'Kirył' => new VocativeSex('Kirył', 'M', 'Kiryle'),
            'Miriam' => new VocativeSex('Miriam', 'W', 'Miriam'),
            'Margot' => new VocativeSex('Margot', 'W', 'Margot'),
            'Ingrid' => new VocativeSex('Ingrid', 'W', 'Ingrid'),
            'Lew' => new VocativeSex('Lew', 'M', 'Lwie'),
            'Narcyz' => new VocativeSex('Narcyz', 'M', 'Narcyzie'),
            'Kosma' => new VocativeSex('Kosma', 'M', 'Kosmo'),
            'Bonawentura' => new VocativeSex('Bonawentura', 'M', 'Bonawenturo'),
            'Carmen' => new VocativeSex('Carmen', 'W', 'Carmen'),
            'Doris' => new VocativeSex('Doris', 'W', 'Doris'),
            'Dolores' => new VocativeSex('Dolores', 'W', 'Dolores'),
            'Abigail' => new VocativeSex('Abigail', 'W', 'Abigail'),
            'Nikolett' => new VocativeSex('Nikolett', 'W', 'Nikoletto'),
            'Ania' => new VocativeSex('Ania', 'W', 'Aniu')
    };


    /**
     * @description
     *
     * @param first_name
     * @param encoding TODO: encoding = 'UTF-8'
     * @param titles
     * @param exceptions
     **/
    public VocativePolishFirstName (String first_name, String encoding, Map<String, String> titles, Map<String, VocativeSex> exceptions) {
        if (!titles.isEmpty()) {
            this.setTitles(titles);
        }

        if (!exceptions.isEmpty()) {
            this.exceptions.putAll(exceptions);
        }

        this.setEncoding(encoding);
        this.remakeToVocative(first_name);
    }

    public VocativePolishFirstName (String first_name) {
        this(first_name, '', new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>());
    }

    /**
     * @description Return default titles definition
     *
     * @return array
     */
    public Map<String, String> getTitles() {
        return this.titles.get('default');
    }

    /**
     * @description Returns titles definition by group name
     *
     * @param aGroup TODO: aGroup = 'default'
     *
     * @return Map<String, String>
     */
    public Map<String, String> getTitlesByGroup(String aGroup) {
        return this.titles.get(aGroup);
    }

    //TODO: add ApexDoc
    public void setTitles(Map<String, String> titles) {
        setTitles(titles, 'default');
    }
    /**
     * @description Setup own title
     * <p/>
     * for english ex. ['U' => '', 'M' => 'Mrs.', 'W' => 'Mr.'];
     * <p/>
     * for polish ex. ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     * <p/>
     * For multiple titles definitions use group name
     * <p/>
     * for polish ex. group: 'default' => ['U' => 'Panie &#47;  Pani', 'M' => 'Panie', 'W' => 'Pani'];
     * <p/>
     * for polish ex. group: 'polite' => ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     *
     * @param titles
     * @param aGroup TODO:  group = 'default'
     */
    public void setTitles(Map<String, String> titles, String aGroup) {
        this.titles.put(aGroup, titles);
    }

    /**
     * Set string encoding
     *
     * @param encoding
     */
    public void setEncoding(String encoding) {
        this.encoding = encoding;
    }

    /**
     * @description Returns array with vocative firs name and gender.
     *
     * @return VocativeSex
     */
    public VocativeSex getVocativeSex() {   //TODO: Change name
        return this.vocative;
    }

    /**
     * @description Returns vocative first name
     *
     * @return string
     */
    public String getVocativeFirstName() { //TODO: Change name
        return this.vocative.vocative;
    }
    /**
     * @description Returns title for a given Group that has been previously defined
     *
     * @param aGroup
     *
     * @return String
     */
    public String getDetectedTitle(String aGroup){
        return this.titles.get(aGroup).get(this.vocative.sex);
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
     * Returns gender M - Male, W - Woman, U - Unknown
     *
     * @return string
     */
    public String getDetectedGender() {
        return this.vocative.sex;
    }


    /**
     * Returns true if first name belongs to man
     *
     * @return bool
     */
    public Boolean isMan()
    {
        if (this.vocative.sex == 'M') {
            return true;
        }

        return false;
    }

    /**
     * Returns true if first name belongs to woman
     *
     * @return bool
     */
    public Boolean isWoman()
    {
        if (this.vocative.sex == 'W') {
            return true;
        }

        return false;
    }

    /**
     * Return vocative first name with title
     *
     * @param string delimiter default ' ' (space)
     * @param string group
     * @return string
     */
    public String getVocativeStringWithTitle(String delimiter, String aGroup) {
        return this.getDetectedTitle(aGroup) + delimiter + this.getVocativeFirstName();
    }

    /**
     * @description Return vocative first name with title, with specified delimiter and default Group
     * @param delimiter
     * @return String
     */
    public String getVocativeStringWithTitle(String delimiter) {
        return getVocativeStringWithTitle(delimiter, 'default');
    }

    // TODO: Missing 'getVocativeStringWithTitle' with Group as a parameter as it's String as well.
    /**
     * @description Return vocative first name with title, with delimiter of Space and default Group
     *
     * @return String
     */
    public String getVocativeStringWithTitle() {
        return getVocativeStringWithTitle(' ', 'default');
    }

    /**
     * @description Convert name to first letter up
     *
     * @param name
     *
     * @return string
     */
    public static String nameCaseConvert(String name) {
        // TODO: Jan-Krzysztof will fail
        String output = '';
        for (String str : name.toLowerCase().splitByCharacterTypeCamelCase()) {
            output += str.capitalize();
        }
        return output;
    }


    /**
     * @description
     *
     * @param first_name
     *
     * @return VocativeSex
     * @exception VocativePolishFirstNameException
     */
    private VocativeSex checkExceptions(String first_name) {
        final VocativeSex nameWithException = this.exceptions.get(first_name);
        if (nameWithException == null) {
            return null;
        }

        if (!nameWithException.hasDefinedVocativeAndSex()) {
            throw new VocativePolishFirstNameException('Invalid format - exception to the rules of firstname must have specified gender and vocative form.');
        }

        switch on nameWithException.sex {
            when 'M', 'W', 'U' {
                return nameWithException;
            }
            when else {
                throw new VocativePolishFirstNameException('Undefined gender');
            }
        }

    }


    /**
     * Remake first name to Polish vocative
     *
     * @param string first_name
     * @return array
     * @throws \Exception
     */

    public void remakeToVocative(String firstname) {
        if (String.isBlank(firstname)) {
            throw new  VocativePolishFirstNameException('First name cannot be empty');
        }

        if (this.vocative == null) {
            firstname = nameCaseConvert(firstname).trim();
            VocativeSex creatingVocative = new VocativeSex(firstname, '', '');
            this.vocative = creatingVocative;
//            mb_internal_encoding(this._encoding);
            for (String first_name : firstname.splitByCharacterTypeCamelCase()) {

                VocativeSex tempVocative = this.checkExceptions(first_name);

                if (tempVocative != null) {
                    this.vocative = tempVocative;
                    return;
                }

                final Integer first_nameLength = first_name.length();

                if (first_nameLength < 2) {
                    creatingVocative.attachToVocativeSex('', '', first_name.toLowerCase());
                    continue;
                }

                try {

                    if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'ni', 'li', 'zi'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name);
                    }
                    else if ( (first_name.endsWithIgnoreCase('eł'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 2)) + 'le');
                    }
                    else if ( (first_name.endsWithIgnoreCase('ił'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 1)) + 'le');
                    }
                    else if ( (first_name.endsWithIgnoreCase('et'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 1)) + 'cie');
                    }
                    else if ( (first_name.endsWithIgnoreCase('tr'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name + 'ze');
                    }
                    else if ( (first_name.endsWithIgnoreCase('ał'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 1)) + 'le');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'it', 'rt'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 1)) + 'cie');
                    }
                    else if ( (first_name.endsWithIgnoreCase('ciek'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 4)) + 'ćku');
                    }
                    else if ( (first_name.endsWithIgnoreCase('siek'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 4)) + 'śku');
                    }
                    else if ( (first_name.endsWithIgnoreCase('niec'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 4)) + 'ńcu');
                    }
                    else if ( (first_name.endsWithIgnoreCase('per'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 2)) + 'rze');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'ek', 'ko'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 2)) + 'ku');
                    }
                    else if ( (first_name.endsWithIgnoreCase('st'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 2)) + 'ście');
                    }
                    else if ( (first_name.endsWithIgnoreCase('sł'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 2)) + 'śle');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'cja', 'ria', 'lia', 'dia', 'wia', 'fia', 'iela', 'bela', 'zula', 'saba'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'W', (chopString(first_name, 1)) + 'o');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'iola', 'rola'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'W', (chopString(first_name, 1)) + 'u');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'aja', 'sia'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'W', (chopString(first_name, 1)) + 'u');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'ja', 'ia', 'la'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'W', (chopString(first_name, 1)) + 'o');
                    }
                    else if ( (first_name.endsWithIgnoreCase('ba'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 1)) + 'o');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'oe', 'ue'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name);
                    }
                    else if ( (first_name.endsWithIgnoreCase('oń'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 1)) + 'niu');
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'n', 'f', 'm', 'w', 'p', 's', 'b'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name + 'ie');
                    }
                    else if ( (first_name.endsWithIgnoreCase('bel'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 3)) + 'ble');
                    }
                    else if ( (first_name.endsWithIgnoreCase('ez'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'W', first_name);
                    }
                    else if (endsWithAnySpecifiedIgnoreCase(first_name, new Set<String>{'g', 'h', 'j', 'k', 'l', 'z'})) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name + 'u');
                    }
                    else if ( (first_name.endsWithIgnoreCase('der'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 2)) + 'rze');
                    }
                    else if ( (first_name.endsWithIgnoreCase('ster'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 2)) + 'rze');
                    }
                    else if ( (first_name.endsWithIgnoreCase('r'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name + 'ze');
                    }
                    else if ( (first_name.endsWithIgnoreCase('d'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name + 'zie');
                    }
                    else if ( (first_name.endsWithIgnoreCase('a'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'W', (chopString(first_name, 1)) + 'o');
                    }
                    else if ( (first_name.endsWithIgnoreCase('e'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'W', first_name);
                    }
                    else if ( (first_name.endsWithIgnoreCase('y'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name);
                    }
                    else if ( (first_name.endsWithIgnoreCase('o'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', first_name);
                    }
                    else if ( (first_name.endsWithIgnoreCase('t'))) {
                        creatingVocative.attachToVocativeSex(first_name, 'M', (chopString(first_name, 1)) + 'cie');
                    }
                    else {
                        creatingVocative.attachToVocativeSex(first_name, 'U', first_name);
                    }

                }
                catch (StringException e) {
                    throw new VocativePolishFirstNameException('An error with name ' + first_name + ':  ' + e, e);
                }
            }


        }
    }

    public static Boolean endsWithAnySpecifiedIgnoreCase(final String aString, final Set<String> suffixes) {
        Boolean doesStringEndsWithAnySuffix = false;
        for (String suffix : suffixes) {
            doesStringEndsWithAnySuffix |= aString.endsWithIgnoreCase(suffix);
        }
        return doesStringEndsWithAnySuffix;
    }

    public static String chopString(final String aString, final Integer amountOfLettersToRemoveFromRight) {
        return (aString.substring(0, aString.length() - amountOfLettersToRemoveFromRight));
    }

    public class VocativeRule {
        public Set<String> nameEndings;
        public String gender;
        public Integer replaceFromRight;
        public String vocativeSuffix;


        public VocativeRule(String nameEnding, String gender, Integer replaceFromRight, String vocativeSuffix) {
            this(new Set<String>{nameEnding}, gender, replaceFromRight, vocativeSuffix);
        }

        public VocativeRule(Set<String> nameEndings, String gender, Integer replaceFromRight, String vocativeSuffix) {
            this.nameEndings = nameEndings;
            this.gender = gender;
            this.replaceFromRight = replaceFromRight;
            this.vocativeSuffix = vocativeSuffix;
        }

        public Boolean isEndingMatching(final String firstname){
            return endsWithAnySpecifiedIgnoreCase(firstname, this.nameEndings);
        }

        public String getVocativeName(final String firstname){
            return (chopString(firstname, this.replaceFromRight)) + vocativeSuffix;
        }

    }
}