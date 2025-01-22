#let project(
  title: "论文题目",
  subtitle: "",
  author: "学生姓名",
  id: "学生学号",
  teacher: "指导教师",
  teacher2: "实践导师",
  college: "所在院系",
  major: "学科专业",
  field: "研究方向",
  date: datetime.today(),
  english_title: "",
  abstract: [],
  // A list of index terms to display after the abstract.
  index-terms: (),
  // The article's paper size. Also affects the margins.
  paper-size: "us-letter",
  // The result of a call to the `bibliography` function or `none`.
  bibliography: none,
  // How figures are referred to from within the text.
  // Use "Figure" instead of "Fig." for computer-related publications.
  figure-supplement: [Fig.],
  // The paper's content.
  body,
) = {
  set document(title: title + subtitle, author: author)
  set text(font: "SimSun", size: 10.5pt)
  set enum(numbering: "1.a.i.")
  show strong: set text(font: "SimHei", weight: "bold")

  let table_underline(s) = [
    #s
    #v(-1em)
    #line(length: 100%, stroke: 1pt)
  ]

  align(center)[
    #v(22pt)
    #set text(font: "STXingkai", size: 22pt, spacing: 22pt)
    中国科学技术大学

    #set text(font: "SimHei", size: 26pt)
    研究生学位论文开题报告

    #v(52pt)
    #set text(font: "SimSun", size: 22pt)
    #table(
      columns: (30%, 70%),
      rows: 35.75pt,
      align: (right, center),
      stroke: none,
      [论文题目], table_underline[#title],
      [　　　　], table_underline[#subtitle],
      [学生姓名], table_underline[#author],
      [学生学号], table_underline[#id],
      [指导教师], table_underline[#teacher],
      [实践导师], table_underline[#teacher2],
      [所在院系], table_underline[#college],
      [学科专业], table_underline[#major],
      [研究方向], table_underline[#field],
      [填表日期], table_underline[#date.display("[year]年[month]月[day]日")],
    )

    #v(15pt)
    #set text(font: "STKaiti", size: 15pt)
    中国科学技术大学研究生院培养办公室

    二零二四年六月 制表
  ]
  pagebreak()

  align(center)[
    #set text(font: "SimSun", size: 22pt)
    #v(22pt)
    *说 明*
    #v(44pt)
    #set align(left)
    #set text(font: "STKaiti", size: 18pt, spacing: 18pt)
    + 抓好研究生学位论文开题报告工作是保证学位论文质量的一个重要环节。为加强对研究生培养的过程管理，规范研究生学位论文的开题报告，特印发此表。

    + 研究生一般应在课程学习结束之后的第一个学期内主动与导师协商，完成学位论文的开题报告。

    + 研究生需在学科点内报告，听取意见，进行论文开题论证。

    + 研究生论文开题论证通过后，在本表末签名后将此表交所在学院教学办公室备查。
  ]
  pagebreak()

  show heading.where(level: 1): it => block(width: 100%)[
    #set text(weight: "bold")
    #smallcaps(it.body)
  ]
  set heading(numbering: "一.", )
  [= 简况]

  body

  // Display bibliography.
  bibliography
}
