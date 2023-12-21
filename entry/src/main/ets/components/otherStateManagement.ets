@Component
export struct OtherStateManagement {
  @State firstName: string = 'Mark'
  @State @Watch('handleLastnameChange') lastName: string = 'Allen'
  @State fullName: string = this.firstName + ' ' + this.lastName

  handleLastnameChange(): void {
    this.fullName = this.firstName + ' ' + this.lastName
  }

  build() {
    Column({ space: 10 }) {
      Text(`firstName: ${this.firstName}`)
      Text(`lastName: ${this.lastName}`)
        .onClick(() => {
          this.lastName += '!'
        })
      Text(`fullname: ${this.fullName}`)
    }
  }
}