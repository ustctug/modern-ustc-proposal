#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/fontawesome:0.5.0": fa-icon

//- path (yaml): your published papers' yaml
#let display-bibliography(yaml) = for (lbl, _) in yaml {
  block[#cite(label(lbl), form: "full")]
}

//- text (string): add an underline under it
#let underline(text) = {
  text
  v(-1em)
  line(length: 100%, stroke: 1pt)
}

//- candidates (string[]): candidates
//- check-index (integer): index of selected candidate
//- join-length (length): join length
#let check-square(candidates, check-index, join-length: 1em) = (
  candidates
    .enumerate()
    .map(((index, element)) => [#fa-icon(int(index == check-index) * "check-" + "square", solid: false) #element])
    .join(h(join-length))
)
#let check-square-other(candidates, check-index-or-str, join-length: 1em) = {
  let check-index = check-index-or-str
  if type(check-index-or-str) == type("") {
    check-index = candidates.len() - 1
  }
  (
    candidates
      .enumerate()
      .map(((index, element)) => [#fa-icon(int(index == check-index) * "check-" + "square", solid: false) #element])
      .join(h(join-length))
      + " "
  )
  box(width: 6em)[
    #set align(center)
    #underline(if type(check-index-or-str) == type("") { check-index-or-str })
  ]
}
//- condition (bool): condition
#let if-square(condition) = fa-icon(int(condition) * "check-" + "square", solid: false)
//- id (string): Chinese citizens id
#let get-gender-from-id(id) = if calc.odd(int(id.at(16))) { "男" } else { "女" }
//- id (string): Chinese citizens id
#let get-birth-date-from-id(id) = datetime(
  year: int(id.slice(6, 10)),
  month: int(id.slice(10, 12)),
  day: int(
    id.slice(
      12,
      14,
    ),
  ),
)
//- id (string): student id
#let get-admission-date-from-student-id(id) = datetime(year: 2000 + int(id.slice(2, 4)), month: 9, day: 1)
// https://www.ustcif.org.cn/default.php/content/2420/
//- SB: major scholar
//- BE: engineering bachelor
//- id (string): student id
#let is-doctor-from-student-id(id) = id.at(0) == "B"
//- SA: academic scholar
//- BA: academic bachelor
//- id (string): student id
#let is-academic-from-student-id(id) = id.at(1) == "A"
//- SD: 在职硕士
//- BD: 在职博士
//- id (string): student id
#let is-work-from-student-id(id) = id.at(1) == "D"
//- id (string): student id
#let get-student-class-from-student-id(id) = (
  2 * int(is-doctor-from-student-id(id)) + int(not is-academic-from-student-id(id))
)
// https://www.teach.ustc.edu.cn/education/239.html
#let colleges = (
  "000": "少年班学院",
  "001": "数学科学学院",
  "002": "物理系",
  "003": "化学物理系",
  "004": "近代物理系",
  "005": "近代力学系",
  "006": "电子工程与信息科学系",
  "008": "分子生物学与细胞生物学系",
  "009": "精密机械与精密仪器系",
  "010": "自动化系",
  "011": "计算机科学与技术系",
  "012": "应用化学系",
  "013": "热科学和能源工程系",
  "014": "材料科学与工程系",
  "015": "工商管理系",
  "016": "管理科学系",
  "017": "统计与金融系",
  "018": "外语系",
  "019": "化学系",
  "020": "高分子科学与工程",
  "021": "神经生物学与生物物理学系",
  "022": "天文学系",
  "023": "电子科学与技术系",
  "024": "科技史与科技考古系",
  "025": "科技传播系",
  "026": "人工智能专业",
  "030": "安全科学与工程系",
  "031": "系统生物学系",
  "032": "医药生物技术系",
  "033": "信息安全专业",
  "038": "光学与光学工程系",
  "045": "数学系",
  "046": "计算与应用数学系",
  "047": "概率统计系",
  "048": "工程与应用物理系",
  "051": "加速器科学与工程物理系",
  "052": "等离子体物理与聚变工程系",
  "053": "核科学与工程系",
  "071": "地球物理与空间科学技术系",
  "072": "地球化学与环境科学系",
  "203": "物理学院",
  "204": "管理学院",
  "206": "化学与材料科学学院",
  "207": "生命科学学院",
  "208": "地球和空间科学学院",
  "209": "工程科学学院",
  "210": "信息科学技术学院",
  "211": "人文与社会科学学院",
  "214": "核科学技术学院",
  "215": "计算机科学与技术学院",
  "218": "先进技术研究院",
  "219": "微电子学院",
  "221": "网络空间安全学院",
  "225": "软件学院",
  "229": "人工智能与数据科学学院",
  "240": "环境科学与工程系",
  "910": "生命科学与医学部",
  "913": "临床医学院",
  "920": "信息与智能学部",
  "999": "未来技术学院",
)
//- id (string): student id
#let get-college-from-student-id(id) = colleges.at(id.slice(4, 7))

//- titles (string[]): split the too long title to many parts
//- author (string): your name
//- student-id (string): your admission date and college will be known here
//- teachers (string[]): 1st teacher is your tutor, 2nd is your practical teacher
//- major (string): refer http://www.moe.gov.cn/srcsite/A08/moe_1034/s4930/202403/W020240319305498791768.pdf
//- field (string): your field name
//- date (datetime): date when you finish your proposal
//- id (string): your Chinese citizens id. no verify like https://github.com/jealyn/idcard-verify
//- english-title (string): English translation of `titles.join()`
//- abstract (content): abstract of your paper
//- keywords (string[]): 3 keywords of your paper
//- english-keywords (string[]): English translation of `keywords`
//- publication-bibliography (yaml | none): the bibliography of your publications
//- signature (boolean | content): signature
//- teachers-signatures ((boolean | content)[]): teachers' signatures
//- teachers-opinion (content): teachers' opinion
//- research-project (string): your tutor's research project name
//- secret-level (0 | 1 | 2 | 3): no secret | confidential | secret | top secret
//- achievement-type (integer): see section 1
//- body (content): the content of the proposal
#let project(
  titles: ("基于 typst 的", "USTC 开题报告模板的开发研究"),
  author: "君の名前",
  student-id: "BE21001001",
  teachers: ("校内导师", "第二导师", "实践导师"),
  major: "学科专业",
  field: "研究方向",
  date: datetime.today(),
  id: "11234519700101123X",
  english-title: "英文要和中文对应，允许适当变通，但不能差异太大",
  abstract: [摘要不分段，围绕研究意义、拟开展的研究内容撰写，两部分的长度基本相当。整个摘要 1000 字以内。],
  keywords: ("一", "二", "三"),
  english-keywords: ("one", "two", "three"),
  publication-bibliography: none,
  signature: true,
  teachers-signatures: (true, true),
  teachers-opinion: "同意开题",
  research-project: "工程博士必须填写研究所依托的重大工程项目，并标明项目编号。",
  secret-level: 0,
  achievement-type: 0,
  body,
) = {
  assert(keywords.len() > 2 and keywords.len() < 6 and english-keywords.len() > 2 and english-keywords.len() < 6, message: "关键词数量三至五个")
  if is-academic-from-student-id(id) {
    assert(teachers.len() > 0, message: "你的导师呢？")
  } else {
    assert(teachers.len() > 1, message: "专业学位硕博生必须有实践导师！")
  }
  let cn-title = titles.join()

  if signature == true {
    signature = [
      // 方正静蕾
      #set text(font: "FZJingLeiS-R-GB", style: "italic")
      #author
    ]
  } else if signature == false {
    signature = [　　　　]
  }
  if teachers-signatures.len() < 1 {
    teachers-signatures.push(true)
  }
  if teachers-signatures.len() < 2 {
    teachers-signatures.push(true)
  }
  if teachers-signatures.at(0) == true {
    teachers-signatures.at(0) = [
      #teachers.at(0)
    ]
  } else if teachers-signatures.at(0) == false {
    teachers-signatures.at(0) = [　　　　]
  }
  if not is-academic-from-student-id(id) {
    if teachers-signatures.at(1) == true {
      // 民间手抄写
      teachers-signatures.at(1) = [
        #set text(font: "MJT-5982", style: "italic")
        #teachers.at(teachers.len() - 1)
      ]
    } else if teachers-signatures.at(1) == false {
      teachers-signatures.at(teachers.len() - 1) = [　　　　]
    }
  }

  show: show-cn-fakebold
  show heading: set text(size: 10.5pt, weight: "regular")
  show heading.where(level: 1): set text(font: "SimHei", size: 15pt)

  set bibliography(title: none, style: "gb-7714-2015-numeric")
  set par(first-line-indent: (amount: 2em, all: true))
  set image(width: 50%)
  set document(title: cn-title, author: author)
  set text(font: ("Times New Roman", "SimSun"), size: 10.5pt, lang: "zh")
  set enum(numbering: "1.a.i.")
  set page(numbering: "1")
  set heading(
    numbering: (
      (..args) => if args.pos().len() == 1 {
        numbering("一.", ..args)
      } else {
        numbering("1.1.", ..args)
      }
    ),
  )

  align(center)[
    #set text(font: "STXingkai", size: 22pt)
    #v(1em)
    中国科学技术大学

    #set text(font: "SimHei", size: 26pt)
    #if is-academic-from-student-id(student-id) [学术] else [专业]学位研究生学位申请成果开题报告

    #v(2em)
    #set text(font: "SimSun", size: 22pt)
    #table(
      columns: (25%, 20%, 100% - 45%),
      rows: 1.625em,
      align: (right, center, center),
      stroke: none,
      table.cell(align: left, colspan: 2)[学位申请成果题目:], underline(titles.at(0)),
      table.cell(align: center, colspan: 3)[#titles.slice(1).map(text => underline(text)).at(0)],
      [学生姓名:], table.cell(align: center, colspan: 2)[#underline(author)],
      [学生学号:], table.cell(align: center, colspan: 2)[#underline(student-id)],
      [校内导师:], table.cell(align: center, colspan: 2)[#underline(teachers.at(0))],
      ..(
        if teachers.len() > (if is-academic-from-student-id(student-id) { 1 } else { 2 }) {
          ([第二导师:], table.cell(align: center, colspan: 2)[#underline(teachers.at(1))])
        } else { () }
      ),
      ..(
        if not is-academic-from-student-id(student-id) {
          ([实践导师:], table.cell(align: center, colspan: 2)[#underline(teachers.at(-1))])
        } else { () }
      ),
      [所在院系:], table.cell(align: center, colspan: 2)[#underline(get-college-from-student-id(student-id))],
      [学科专业:], table.cell(align: center, colspan: 2)[#underline(major)],
      [研究方向:], table.cell(align: center, colspan: 2)[#underline(field)],
      [填表日期:], table.cell(align: center, colspan: 2)[#underline(date.display("[year]年[month]月[day]日"))],
    )

    #v(1em)
    #set text(font: "SimHei", size: 15pt)
    *中国科学技术大学研究生院培养处*

    *二零二五年三月 制表*
  ]
  pagebreak()

  align(center)[
    #set text(font: "SimSun", size: 22pt)
    #v(1em)
    *说　明*
    #v(2em)
    #set align(left)
    #set text(font: "STKaiti", size: 18pt, spacing: 18pt)
    + 抓好研究生学位论文开题报告工作是保证学位论文质量的一个重要环节。为加强对研究生培养的过程管理，规范研究生学位论文的开题报告，特印发此表。

    + 研究生一般应在课程学习结束之后的第一个学期内主动与导师协商，完成学位论文的开题报告。

    + 研究生需在学科点内报告，听取意见，进行论文开题论证。

    + 研究生论文开题论证通过后，在本表末签名后将此表交所在学院教学办公室备查。
  ]
  pagebreak()

  [
    = 简况
    #if is-academic-from-student-id(student-id) {
      table(
        inset: 0pt,
        columns: (1.5em, 100% - 1.5em),
        rows: (12em, 52.93em),
        align: center + horizon,
        [研究生简介],
        table(
          inset: 0pt,
          rows: 1fr,
          table(
            columns: (13%, 100% - 13% * 3 - 20% * 2, 13%, 20%, 13%, 20%),
            rows: 1fr,
            [姓　名], author, [学　号], student-id, [出生年月], get-birth-date-from-id(id).display("[year]年[month]月"),
          ),
          table(
            columns: (13%, 7%, 100% - 13% - 7% - 66%, 66%),
            rows: 1fr,
            [性　别], get-gender-from-id(id), [身份证号], id,
          ),
          table(
            columns: (13%, 100% - 13% - 20% - 33%, 20%, 33%),
            rows: 1fr,
            [入学时间],
            get-admission-date-from-student-id(student-id).display("[year]年[month]月"),
            [培养方式],
            check-square(([脱产], [不脱产]), int(is-work-from-student-id(student-id))),
          ),
          table(
            columns: (20%, 100% - 20%),
            rows: 1fr,
            [学生类别],
            check-square(
              ([学术硕士], [专业硕士], [学术博士], [专业博士]),
              get-student-class-from-student-id(student-id),
            ),
          ),
        ),

        [论文内容和意义],
        table(
          inset: 0pt,
          columns: (1.5em, 100% - 1.5em),
          rows: (6em, 100% - 15em, 9em),
          [题目],
          table(
            columns: (12%, 100% - 12%),
            rows: 1fr,
            [中文], cn-title,
            [英文], english-title,
          ),

          [摘要], box(align(abstract, left + top), height: 100%, width: 100%, inset: 5pt),
          [主题词],
          table(
            inset: 0pt,
            rows: (1fr, 2fr),
            [主题词数量不多于三个，主题词之间空一格（英文用“/ ”分隔）],
            table(
              columns: (12%, 100% - 12%),
              rows: 1fr,
              [中文], keywords.join([ ]),
              [英文], english-keywords.join([ \/ ]),
            ),
          ),
        ),
      )
    } else {
      table(
        inset: 0pt,
        columns: (1.5em, 100% - 1.5em),
        rows: (8em, 24em, 26.93em, 6em),
        align: center + horizon,
        text(font: "SimHei")[研究生简介],
        table(
          inset: 0pt,
          rows: 1fr,
          table(
            columns: (13%, 100% - 13% * 3 - 20% * 2, 13%, 20%, 13%, 20%),
            rows: 1fr,
            [姓　名], author, [学　号], student-id, [性　别], get-gender-from-id(id),
          ),
          table(
            columns: (13%, 100% - 13%),
            rows: 1fr,
            [培养方式],
            check-square(([全日制], [非全日制]), int(is-work-from-student-id(student-id)), join-length: 12em),
          ),
        ),

        table.cell(colspan: 2)[
          #table(
            inset: 0pt,
            rows: 1fr,
            columns: (4em, 100% - 4em),
            [
              #if-square(not is-doctor-from-student-id(student-id))

              #text(font: "SimHei")[专业学位硕士]
            ],
            table(
              columns: 1fr,
              rows: 1fr,
              align: left,
              inset: 15pt,
              check-square-other(
                ("专题研究类论文", "调研报告", "案例分析报告", "产品设计（作品创作）", "方案设计", "其他"),
                if is-doctor-from-student-id(student-id) { -1 } else { achievement-type },
              )
            ),

            [
              #if-square(is-doctor-from-student-id(student-id))

              #text(font: "SimHei")[专业学位博士]
            ],
            table(
              columns: (20%, 100% - 20%),
              rows: 1fr,
              align: left + top,
              stroke: none,
              [学位论文申请：],
              if-square(is-doctor-from-student-id(student-id) and achievement-type == 0) + " 专题研究类论文",

              [实践成果申请：],
              check-square-other(
                ("重大装备", "仪器设备", "其他硬件产品", "软件产品", "设计方案", "技术标准", "其他"),
                if is-doctor-from-student-id(student-id) { achievement-type - 1 } else { -1 },
                join-length: 1.8em,
              ),
            ),

            text(font: "SimHei")[学位申请成果题目],
            table(
              columns: (12%, 100% - 12%),
              rows: 1fr,
              [中文], cn-title,
              [英文], english-title,
            ),
          )
        ],

        text(font: "SimHei")[学位申请成果摘要和关键词],
        table(
          inset: 0pt,
          columns: (2.5em, 100% - 2.5em),
          rows: (100% - 6em, 6em),
          box(align([摘要], center), height: 100%, width: 100%, inset: 5pt),
          box(align(abstract, left + top), height: 100%, width: 100%, inset: 5pt),

          box(align([关键词], center), height: 100%, width: 100%, inset: 5pt),
          table(
            inset: 0pt,
            rows: (1fr, 2fr),
            [关键词数量三至五个，主题词之间空一格（英文用“ / ”分隔）],
            table(
              columns: (12%, 100% - 12%),
              rows: 1fr,
              [中文], keywords.join([ ]),
              [英文], english-keywords.join([ \/ ]),
            ),
          ),
        ),

        text(font: "SimHei")[选题来源],
        box(align(research-project, left + top), height: 100%, width: 100%, inset: 5pt),
      )
    }
  ]
  if publication-bibliography != none {
    // force your publications preceder than others
    box(display-bibliography(publication-bibliography), height: 0em, clip: true)
  }

  let headings = ()
  for child in body.children {
    if child.func() == heading and child.depth == 1 {
      if headings.len() > 0 and headings.last().elems.len() == 0 {
        headings.last().elems.push(parbreak())
      }
      headings.push((heading: child, elems: ()))
    } else if headings.len() != 0 {
      headings.last().elems.push(child)
    }
  }

  for section in headings {
    section.heading
    table(
      columns: 100%,
      for elem in section.elems { elem },
    )
  }

  align(
    box[
      研究生本人签名：
      #box(width: 10em)[
        #set align(center)
        #underline(box(signature))
      ]

      校内导师（主导师）签名：
      #box(width: 10em)[
        #set align(center)
        #underline(box(teachers-signatures.at(0)))
      ]

      实践导师签名：
      #box(width: 10em)[
        #set align(center)
        #underline(box(teachers-signatures.at(teachers-signatures.len() - 1)))
      ]

      #date.display("[year]年[month]月[day]日")
    ],
    right + bottom,
  )
  pagebreak(to: "odd")

  align(center)[
    #if is-academic-from-student-id(student-id) {
      v(3em)
      [中国科学技术大学研究生学位论文开题报告评审表]

      set text(font: "SimHei")
      table(
        inset: 0pt,
        rows: (5em, 7.5em, 5em, 2.5em, 17.5em, 10em, 10em),
        align: center + horizon,
        table(
          columns: (13%, 17%, 12%, 21%, 12%, 25%),
          rows: 1fr,
          [姓　名], author, [学　号], student-id, [所在院系], get-college-from-student-id(student-id),
          [学科/专业], major, [研究方向], field, [指导教师], teachers.at(0),
        ),
        table(
          columns: (30%, 100% - 30%),
          rows: 1fr,
          [学生类别],
          check-square(([学术硕士], [专业硕士], [学术博士], [专业博士]), get-student-class-from-student-id(student-id)),

          [拟撰写的学位论文题目], cn-title,
          [支持论文研究的科研项目], research-project,
        ),
        table(
          inset: 0pt,
          columns: (13%, 100% - 13% - 8% - 17%, 8%, 17%),
          rows: 1fr,
          [学位论文

            是否保密],
          table(
            align: left,
            columns: 1fr,
            rows: 1fr,
            [1．不保密（#{ if secret-level == 0 { fa-icon("check-square", solid: false) } else [ ] }）],
            [2．保密 （#{ if secret-level > 0 { fa-icon("check-square", solid: false) } else [ ] }） 密级：绝密（#{ if secret-level == 3 { fa-icon("check-square", solid: false) } else [ ] }）、机密（#{ if secret-level == 2 { fa-icon("check-square", solid: false) } else [ ] }）、秘密（#{ if secret-level == 1 { fa-icon("check-square", solid: false) } else [ ] }）],
          ),
          [导师

            签字],
          [
            #teachers-signatures.at(0)
          ],
        ),
        [开题报告评审组成员名单],
        {
          set text(font: "SimSun")
          table(
            columns: (20%, 15%, 100% - 20% - 15% - 25%, 25%),
            rows: 7 * (1fr,),
            [姓名], [职称], [工作单位], [签名],
          )
        },
        box(height: 100%, width: 100%, inset: 5pt)[
          #set text(font: "SimSun")
          #align(left + top)[
            指导教师意见：

            #teachers-opinion
          ]
          #align(right + bottom)[
            指导教师签字：#box(teachers-signatures.at(0)) 实践导师签字（专业学位硕博生须签字）：#box(teachers-signatures.at(1))

            #date.display("[year]年[month]月[day]日")
          ]
        ],
        box(height: 100%, width: 100%, inset: 5pt)[
          #set text(font: "SimSun")
          #align(left + top)[
            评审小组意见：（是否通过开题论证，是否需要修改等）
          ]
          #align(right + bottom)[
            评审小组组长签字：　　　　// keep spaces

            年　月　日
          ]
        ],
      )
    } else {
      text(font: "SimHei", size: 15.5pt)[中国科学技术大学专业学位研究生学位申请成果开题报告评审表]

      table(
        inset: 0pt,
        rows: (2.5em, 5em, 7.5em, 5em, 2.5em, 17.5em, 8.5em, 5em, 5em, 5em),
        align: center + horizon,
        table(
          columns: (13%, 17%, 12%, 21%, 12%, 25%),
          rows: 1fr,
          text(font: "SimHei")[姓　　名],
          author,
          text(font: "SimHei")[学　　号],
          student-id,
          text(font: "SimHei")[性　　别],
          get-gender-from-id(id),
        ),
        table(
          columns: (13%, 17% + 12%, 21%, 12% + 25%),
          rows: 1fr,
          text(font: "SimHei")[所在院系],
          get-college-from-student-id(student-id),
          text(font: "SimHei")[学科、专业],
          major,

          text(font: "SimHei")[研究方向], field, text(font: "SimHei")[指导教师], teachers.at(0),
        ),
        table(
          columns: (37%, 100% - 37%),
          rows: 1fr,
          text(font: "SimHei")[学生类别],
          check-square(([专业学位硕士], [专业学位博士]), int(is-doctor-from-student-id(student-id)), join-length: 6em),

          text(font: "SimHei")[拟撰写的学位申请成果题目], cn-title,
          text(font: "SimHei")[支持学位申请成果研究的科研项目], research-project,
        ),
        table(
          inset: 0pt,
          columns: (13%, 100% - 13% - 8% - 17%, 8%, 17%),
          rows: 1fr,
          text(font: "SimHei")[学位申请成

            果是否保密],
          table(
            align: left,
            columns: 1fr,
            rows: 1fr,
            [1．不保密（#{ if secret-level == 0 { fa-icon("check-square", solid: false) } else [ ] }）],
            [2．保密 （#{ if secret-level > 0 { fa-icon("check-square", solid: false) } else [ ] }） 密级：绝密（#{ if secret-level == 3 { fa-icon("check-square", solid: false) } else [ ] }）、机密（#{ if secret-level == 2 { fa-icon("check-square", solid: false) } else [ ] }）、秘密（#{ if secret-level == 1 { fa-icon("check-square", solid: false) } else [ ] }）],
          ),
          [导师

            签字],
          [
            #teachers-signatures.at(0)
          ],
        ),
        text(font: "SimHei")[开题报告评审组成员名单],
        {
          set text(font: "SimSun")
          table(
            columns: (20%, 15%, 100% - 20% - 15% - 25%, 25%),
            rows: 7 * (1fr,),
            text(font: "SimHei")[姓名],
            text(font: "SimHei")[职称],
            text(font: "SimHei")[工作单位],
            text(font: "SimHei")[签名],
          )
        },
        table(
          rows: 1fr,
          columns: (50%, 50%),
          stroke: none,
          align: left,
          table.cell(colspan: 2)[指导教师意见：

            #teachers-opinion],
          align(right + bottom)[
            校内教师（主导师）签字：#box(teachers-signatures.at(0))

            #date.display("[year]年[month]月[day]日")
          ],
          align(right + bottom)[
            实践导师签字：#box(teachers-signatures.at(1))

            #date.display("[year]年[month]月[day]日")
          ]
        ),
        box(height: 100%, width: 100%, inset: 5pt)[
          #set text(font: "SimSun")
          #align(left + top)[
            评审小组意见：（是否通过开题论证，是否需要修改等）
          ]
        ],
        table(
          columns: (25%, 25%, 25%, 25%),
          rows: 1fr,
          table.cell(colspan: 3)[#text(font: "SimHei")[#if-square(false) 通过]],
          table.cell(rowspan: 2)[#text(font: "SimHei")[#if-square(false) 不通过]],
          [#if-square(false) 优秀],
          [#if-square(false) 良好],
          [#if-square(false) 一般],
        ),
        box(height: 100%, width: 100%, inset: 5pt)[
          #align(right + bottom)[
            评审小组组长签字：　　　　// keep spaces

            年　月　日
          ]
        ]
      )
    }
  ]
}
